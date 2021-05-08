import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meme_creator_2/meme_creator_2.dart';

void main() {
  const MethodChannel channel = MethodChannel('meme_creator_2');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await MemeCreator_2.platformVersion, '42');
  });
}
