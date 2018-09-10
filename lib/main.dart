import 'package:flutter/material.dart';
import 'alertDialogEx.dart';
import 'DateTimePickerExample.dart';
import 'textInputExample.dart';
import 'notificationExample.dart';
import 'switchExample.dart';
import 'checkBoxExample.dart';
import 'customListViewExample/customListView.dart';
import 'databaseExample1/main.dart';
import 'firebaseGmailAuthentication.dart';



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
    new DrawerItem("0.Alert Dialog", Icons.add_alert),
    new DrawerItem("1.Date Time Picker", Icons.date_range),
    new DrawerItem("2.Text Input", Icons.text_fields),
    new DrawerItem("3.Notificaton Example", Icons.notifications_active),
    new DrawerItem('4.Switch Example',Icons.switch_camera),
    new DrawerItem('5.Check Box Example',Icons.check_box),
    new DrawerItem('6.Custom List View Example', Icons.format_list_bulleted),
    new DrawerItem('7.Database Example', Icons.developer_board),
    new DrawerItem('8.Firebase Gmail Authiencation', Icons.mail),
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
      case 4:
        return new SwitchExample();
      case 5:
        return new CheckBoxExample();
      case 6:
        return new ListViewApp();
      case 7:
        return new MyAppDB1();
      case 8:
        return new FirebaseGmailAuthientication();
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
            /*
            new UserAccountsDrawerHeader(
                accountName: new Text("John Doe"), accountEmail: null),
            */
            new Column(children: drawerOptions)
          ],
        ),
      ),

      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
