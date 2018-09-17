import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';


class FirebaseGmailAuthientication extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<FirebaseGmailAuthientication>{


  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userDisplayName = 'unknown user';
  FirebaseUser user;


  Future<FirebaseUser> _handleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    print("signed in " + user.displayName);

    setState(() {
      userDisplayName =  user.email;

    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userDisplayName', user.displayName);
    await prefs.setString('userEmail', user.email);
    await prefs.setString('userAvatarUrl', user.photoUrl);

    print(prefs.getString('userDisplayName'));

    return  user;
  }

  void _signOut() async {
    _googleSignIn.signOut();
    print("user signed out");
    setState(() {
      userDisplayName = 'unknown user';
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userDisplayName', 'unknown user from SharedPreferences');
    await prefs.setString('userEmail', 'unknown email from SharedPreferences');
    await prefs.setString('userAvatarUrl', '');

    print(prefs.getString('userDisplayName'));

  }

  void _keepLogin() async{
    FirebaseUser firebaseUser = await _auth.currentUser();
    if (_auth.currentUser() != null){

      setState(() {
        userDisplayName = firebaseUser.email;
        user = firebaseUser;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userDisplayName', firebaseUser.displayName);
      await prefs.setString('userEmail', firebaseUser.email);
      await prefs.setString('userAvatarUrl', firebaseUser.photoUrl);
    }
    print(firebaseUser);
  }


  @override
  void initState() {
    _keepLogin();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        body: new Container(
            padding: new EdgeInsets.all(10.0),
            child: new Column(
              children: <Widget>[
                new Center(
                  child: new Text( userDisplayName),
                ),
                new FutureBuilder(
                    future: SharedPreferences.getInstance(),
                    builder: (context,snapshot){
                      if (snapshot.hasData){
                        SharedPreferences prefs = snapshot.data;
                        if (prefs.getString('userAvatarUrl') != '')
                          return UserAccountsDrawerHeader(
                            decoration: new BoxDecoration(color: Colors.transparent),
                            accountName: new Text(prefs.getString("userDisplayName"),style: new TextStyle(color: Colors.black) ),
                            accountEmail: new Text(prefs.getString("userEmail"),style: new TextStyle(color: Colors.black) ),
                            currentAccountPicture: new CircleAvatar( backgroundImage: new NetworkImage(prefs.getString("userAvatarUrl"))) ,
                          );
                        else
                          return UserAccountsDrawerHeader(
                            decoration: new BoxDecoration(color: Colors.transparent),
                            accountName: new Text(prefs.getString("userDisplayName"),style: new TextStyle(color: Colors.black)),
                            accountEmail: new Text(prefs.getString("userEmail"),style: new TextStyle(color: Colors.black)),
                            currentAccountPicture: new CircleAvatar( backgroundImage: new AssetImage('assets/avatar.png') ),
                          );
                      }
                      else
                        return UserAccountsDrawerHeader(
                          decoration: new BoxDecoration(color: Colors.white),
                          accountName: new Text('loading...'),
                          accountEmail: new Text('loading...'),
                          currentAccountPicture: new CircleAvatar( backgroundImage: new AssetImage('assets/avatar.png') ),
                        );
                    }
                ),
                new Row(
                  children: <Widget>[
                    new Text("gmail sign in:"),
                    new RaisedButton(
                        child: new Text("sign in"),
                        onPressed: (){
                          _handleSignIn()
                              .then((FirebaseUser user) => print(user))
                              .catchError((e) => print(e));
                        },)
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Text("gmail sign out:"),
                    new RaisedButton(
                      child: new Text("sign out"),
                      onPressed: _signOut,
                    )
                  ],
                ),
              ],
            )
        )
    );
  }
}