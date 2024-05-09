import 'package:flutter_test/flutter_test.dart';
import 'package:siggetadsplugin/siggetadsplugin.dart';
import 'package:siggetadsplugin/siggetadsplugin_platform_interface.dart';
import 'package:siggetadsplugin/siggetadsplugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSiggetadspluginPlatform
    with MockPlatformInterfaceMixin
    implements SiggetadspluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SiggetadspluginPlatform initialPlatform = SiggetadspluginPlatform.instance;

  test('$MethodChannelSiggetadsplugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSiggetadsplugin>());
  });

  test('getPlatformVersion', () async {
    Siggetadsplugin siggetadspluginPlugin = Siggetadsplugin();
    MockSiggetadspluginPlatform fakePlatform = MockSiggetadspluginPlatform();
    SiggetadspluginPlatform.instance = fakePlatform;

    expect(await siggetadspluginPlugin.getPlatformVersion(), '42');
  });
}
