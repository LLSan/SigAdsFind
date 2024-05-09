
import 'siggetadsplugin_platform_interface.dart';

class Siggetadsplugin {
  Future<String?> getPlatformVersion() {
    return SiggetadspluginPlatform.instance.getPlatformVersion();
  }
}
