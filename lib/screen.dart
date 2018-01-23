import 'dart:async';

import 'package:flutter/services.dart';

class Screen {
  static const MethodChannel _channel = const MethodChannel('github.com/clovisnicolas/flutter_screen');

  static Future<double> get brightness => _channel.invokeMethod('brightness');
  static Future setBrightness(double brightness) =>_channel.invokeMethod('setBrightness',{"brightness" : brightness});
  static Future<bool> get isKeptOn => _channel.invokeMethod('isKeptOn');
  static Future keepOn(bool on) => _channel.invokeMethod('keepOn', {"on" : on});
}
