import 'package:flutter/material.dart';
import 'package:screen/screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isKeptOn = false;
  double _brightness = 1.0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    bool? keptOn = await Screen.isKeptOn;
    double? brightness = await Screen.brightness;
    setState(() {
      _isKeptOn = keptOn ?? false;
      _brightness = brightness ?? 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Screen plugin example')),
        body: Center(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Screen is kept on ? "),
                  Checkbox(
                    value: _isKeptOn,
                    onChanged: (bool? b) {
                      if (b != null) {
                        Screen.keepOn(b);
                        setState(() {
                          _isKeptOn = b;
                        });
                      }
                    },
                  )
                ],
              ),
              Text("Brightness :"),
              Slider(
                value: _brightness,
                onChanged: (double b) {
                  setState(() {
                    _brightness = b;
                  });
                  Screen.setBrightness(b);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
