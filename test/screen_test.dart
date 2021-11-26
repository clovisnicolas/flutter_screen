import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:screen/screen.dart';

void main() {
  const MethodChannel channel = MethodChannel('screen');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  // test('getPlatformVersion', () async {
  //   expect(await Screen.platformVersion, '42');
  // });
}
