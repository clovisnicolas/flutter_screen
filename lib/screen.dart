import 'dart:async';

import 'package:flutter/services.dart';

class Screen {
  Screen._();

  static const MethodChannel _channel = MethodChannel('github.com/clovisnicolas/flutter_screen');

  static Future<double> get brightness => _channel.invokeMethod<double>('brightness');

  static Future<void> setBrightness(double brightness) => _channel.invokeMethod('setBrightness', <String, dynamic>{'brightness': brightness});

  static Future<bool> get isKeptOn => _channel.invokeMethod<bool>('isKeptOn');

  static Future<void> keepOn(bool on) => _channel.invokeMethod('keepOn', <String, dynamic>{'on': on});
}
