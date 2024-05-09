
import 'package:flutter/services.dart';

class SigAdsFindManager {
  static const MethodChannel _channel = MethodChannel('sig_ads_find_plugin');

  static Future<String> getAdKeyword() async {
    final String keyword = await _channel.invokeMethod('getAdKeyword');
    return keyword;
  }
}