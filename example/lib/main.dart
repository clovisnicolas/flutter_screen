import 'package:flutter/material.dart';
import 'package:screen/screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isKeptOn = false;
  double _brightness = 1.0;

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    bool keptOn = await Screen.isKeptOn;
    double brightness = await Screen.brightness;
    setState((){
      _isKeptOn = keptOn;
      _brightness = brightness;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(title: new Text('Screen plugin example')),
        body: new Center(
            child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text("Screen is kept on ? "),
                      new Checkbox(value: _isKeptOn, onChanged: (bool b){
                        Screen.keepOn(b);
                        setState((){_isKeptOn = b; });
                      })
                    ]
                  ),
                  new Text("Brightness :"),
                  new Slider(value : _brightness, onChanged : (double b){
                    setState((){_brightness = b;});
                    Screen.setBrightness(b);
                  })
                ]
            )
        ),
      ),
    );
  }
}
