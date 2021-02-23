# Screen
[![pub package](https://img.shields.io/pub/v/screen.svg)](https://pub.dartlang.org/packages/screen)
A Flutter plugin to manage the device's screen on Android and iOS.

## Usage
To use this plugin, add `screen` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

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
