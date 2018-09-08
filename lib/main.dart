import 'package:flutter/material.dart';
import 'alertDialogEx.dart';
import 'DateTimePickerExample.dart';
import 'textInputExample.dart';
import 'notificationExample.dart';



void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  final drawerItems = [
    new DrawerItem("Alert Dialog", Icons.rss_feed),
    new DrawerItem("Date Time Picker", Icons.local_pizza),
    new DrawerItem("Text Input", Icons.info),
    new DrawerItem("Notificaton Example", Icons.ac_unit),
  ];

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new MyAlertDialogEx();
      case 1:
        return new DateTimePickerExample();
      case 2:
        return new textInputExample();
      case 3:
        return new NotificationExample();
      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {

    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),

      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text("John Doe"), accountEmail: null),
            new Column(children: drawerOptions)
          ],
        ),
      ),

      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
