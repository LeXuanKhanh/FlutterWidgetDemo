import 'package:flutter/material.dart';

class CheckBoxExample extends StatefulWidget {
  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBoxExample>{
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
                    new Checkbox(
                        value: _value,
                        onChanged: (bool value){
                          _onChanged(value);
                        },
                      activeColor: Colors.red,
                    ),
                  ],
                )
              ],
            )
        )
    );
  }
}