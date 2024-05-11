import Flutter
import UIKit
import AdServices

public class SiggetadspluginPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "siggetadsplugin", binaryMessenger: registrar.messenger())
    let instance = SiggetadspluginPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "getAdKeyword":
//      print("getAdKeyword - 来了")
      AdServiceQueryManagerTool.shared.startService { dict in
          DispatchQueue.main.async {
            result(dict)
          }
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}


class AdServiceQueryManagerTool : NSObject{

    static let shared = AdServiceQueryManagerTool()

    var repRequestCount:Int = 0

    func startService(completeBlock: @escaping (_ dict: [String: Any]) -> Void) {

        guard let abToken = getAttributionToken() else {
            completeBlock([:])
            return
        }
        if(AdServiceQueryManagerTool.shared.repRequestCount >= 3) {
            completeBlock([:])
            return
        }
        if AdServiceQueryManagerTool.shared.repRequestCount < 3 {
            requestDetails(abToken: abToken) { dict in
                guard let attribution = dict["attribution"] as? Bool, attribution else {
                    let workItem = DispatchWorkItem {
                        AdServiceQueryManagerTool.shared.repRequestCount += 1
                        AdServiceQueryManagerTool.shared.startService(completeBlock: completeBlock)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: workItem)
                    return
                }
                AdServiceQueryManagerTool.shared.repRequestCount = 0
                completeBlock(dict)
            }
        }else{
            completeBlock([:])
        }
    }

    private func requestDetails(abToken: String, completeBlock: @escaping (_ dict: [String: Any]) -> Void) {
        let url = "https://api-adservices.apple.com/api/v1/"
        guard let requestURL = URL(string: url) else {
             
            completeBlock([:])
            return
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let postData = abToken.data(using: .utf8)
        request.httpBody = postData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completeBlock([:])
                    return
                }

                guard let responseData = data else {
                    completeBlock([:])
                    return
                }

                do {
                    guard let resultDict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else {
                         
                        completeBlock([:])
                        return
                    }
                    // 如果是模拟 Int 值，则不返回
                    if let campaignId = resultDict["campaignId"] as? Int, campaignId == 1234567890 {
                        completeBlock([:])
                        return
                    }
                    completeBlock(resultDict)
                } catch {
                    completeBlock([:])
                }
            }
        }
        task.resume()
    }


    private func getAttributionToken() -> String? {
        if #available(iOS 14.3, *) {
            do {
                let attributionToken = try AAAttribution.attributionToken()
                return attributionToken
            } catch {
                return nil
            }
        }
        return nil
    }

}
