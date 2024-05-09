import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'siggetadsplugin_platform_interface.dart';

/// An implementation of [SiggetadspluginPlatform] that uses method channels.
class MethodChannelSiggetadsplugin extends SiggetadspluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('siggetadsplugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
