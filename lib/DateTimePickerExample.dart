import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DateTimePickerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
          child: new Column(
            children: <Widget>[
              new Text('date: ${formatter.format(_date) }'),
              new RaisedButton(
                  child: new Text(formatter.format(_date)),
                  onPressed:(){selectDate(context);}
              ),
              new RaisedButton(
                  child: new Text('${_time.hour}:${_time.minute}'),
                  onPressed:(){selectTime(context);}
              ),
            ],
          )
      ),
    );
  }



  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();
  DateFormat formatter = new DateFormat('dd/MM/y');

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2018),
        lastDate: new DateTime(9999)
    );

    if (picked != null && picked != _date){
      print('Date Selected: ${_date.toString()}');
      setState((){
        _date = picked;
      });
    }
  }

  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _time);

    if (picked != null && picked != _time){
      print('Time Selected: ${_time.hour} : ${_time.minute}');
      setState((){
        _time = picked;
      });
    }
  }

}





