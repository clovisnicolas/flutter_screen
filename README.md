# Screen
[![pub package](https://img.shields.io/pub/v/screen.svg)](https://pub.dartlang.org/packages/screen)
A Flutter plugin to manage the device's screen on Android and iOS.

## Usage
To use this plugin, add `screen` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

Make sure you add the following permissions to your Android Manifest
```
<uses-permission android:name="android.permission.WAKE_LOCK" />
```

## Caveats

Changing brightness sets the screen brightness for the current app only (on modern Android versions) and it also locks the brightness slider. See https://developer.android.com/reference/android/view/WindowManager.LayoutParams#screenBrightness for API details.

## Example
``` dart
// Import package
import 'package:screen/screen.dart';

// Get the current brightness:
double brightness = await Screen.brightness;

// Set the brightness:
Screen.setBrightness(0.5);

// Check if the screen is kept on:
bool isKeptOn = await Screen.isKeptOn;

// Prevent screen from going into sleep mode:
Screen.keepOn(true);
```
