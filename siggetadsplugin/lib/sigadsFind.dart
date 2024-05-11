
import 'package:flutter/services.dart';

class SigAdsFindManager {
  static const MethodChannel _channel = MethodChannel('siggetadsplugin');

  static Future<Map<String, dynamic>> getAdKeyword() async {
    print("发送：getAdKeyword");
    final Map<String, dynamic> keyword = Map<String, dynamic>.from(await _channel.invokeMethod('getAdKeyword'));
    print("等待ios返回的值");
    print(keyword);
    return keyword;
  }
}