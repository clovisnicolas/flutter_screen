import 'package:flutter/material.dart';
import 'package:screen/screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? _isKeptOn = false;
  double _brightness = 1.0;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    bool keptOn = await Screen.isKeptOn;
    double brightness = await Screen.brightness;
    setState(() {
      _isKeptOn = keptOn;
      _brightness = brightness;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Screen plugin example')),
        body: Center(
            child: Column(children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            const Text("Screen is kept on ? "),
            Checkbox(
                value: _isKeptOn,
                onChanged: (bool? b) {
                  Screen.keepOn(b);
                  setState(() {
                    _isKeptOn = b;
                  });
                })
          ]),
          const Text("Brightness :"),
          Slider(
              value: _brightness,
              onChanged: (double b) {
                setState(() {
                  _brightness = b;
                });
                Screen.setBrightness(b);
              })
        ])),
      ),
    );
  }
}
