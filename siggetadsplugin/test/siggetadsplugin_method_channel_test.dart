import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siggetadsplugin/siggetadsplugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelSiggetadsplugin platform = MethodChannelSiggetadsplugin();
  const MethodChannel channel = MethodChannel('siggetadsplugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
