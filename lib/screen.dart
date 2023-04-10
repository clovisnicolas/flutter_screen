import 'package:flutter/services.dart';

class Screen {
  static const MethodChannel _channel =
      const MethodChannel('github.com/clovisnicolas/flutter_screen');

  static Future<double?> get brightness async =>
      (await _channel.invokeMethod('brightness')) as double?;

  static Future<void> setBrightness(double brightness) =>
      _channel.invokeMethod('setBrightness', {"brightness": brightness});

  static Future<bool?> get isKeptOn async =>
      (await _channel.invokeMethod('isKeptOn')) as bool?;

  static Future<void> keepOn(bool on) =>
      _channel.invokeMethod('keepOn', {"on": on});
}