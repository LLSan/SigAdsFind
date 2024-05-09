import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'siggetadsplugin_method_channel.dart';

abstract class SiggetadspluginPlatform extends PlatformInterface {
  /// Constructs a SiggetadspluginPlatform.
  SiggetadspluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static SiggetadspluginPlatform _instance = MethodChannelSiggetadsplugin();

  /// The default instance of [SiggetadspluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelSiggetadsplugin].
  static SiggetadspluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SiggetadspluginPlatform] when
  /// they register themselves.
  static set instance(SiggetadspluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
