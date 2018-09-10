import 'package:flutter/material.dart';

class SwitchExample extends StatefulWidget {
  @override
  _SwitchExampleState createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample>{
  bool _value = false;
  void _onChanged(bool value){
    setState(() {
      _value = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new Container(
        padding: new EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Text(_value.toString()),
                new Switch(
                    value: _value,
                    onChanged: (bool value){
                      _onChanged(value);
                    },
                    activeColor: Colors.red,
                    activeTrackColor: Colors.blue,
                    inactiveThumbColor: Colors.green,
                    inactiveTrackColor: Colors.yellow,
                )
              ],
            )
          ],
        )
      )
    );
  }
}