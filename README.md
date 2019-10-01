# Screen
[![pub package](https://img.shields.io/pub/v/screen.svg)](https://pub.dartlang.org/packages/screen)
A Flutter plugin to manage the device's screen on Android and iOS.

## Usage
To use this plugin, add `flutter_screen` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

Make sure you add the following permissions to your Android Manifest
```
<uses-permission android:name="android.permission.WAKE_LOCK" />
```

## Example
``` dart
// Import package
import 'package:flutter_screen/flutter_screen.dart';

// Get the current brightness:
double brightness = await Screen.brightness;

// Set the brightness:
FlutterScreen.setBrightness(0.5);

// Check if the screen is kept on:
bool isKeptOn = await FlutterScreen.isKeptOn;

// Prevent screen from going into sleep mode:
FlutterScreen.keepOn(true);

//free brightness (it works only on Android):
FlutterScreen.resetBrightness();
```
