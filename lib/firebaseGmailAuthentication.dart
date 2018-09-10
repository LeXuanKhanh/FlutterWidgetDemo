import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

class FirebaseGmailAuthientication extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<FirebaseGmailAuthientication>{
  String userDisplayName;
  FirebaseUser user;



  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("signed in " + user.displayName);
    setState(() {
      userDisplayName = user.displayName;
    });
    return user;
  }

  void _signOut(){
    _googleSignIn.signOut();
    print("user signed out");
    setState(() {
      userDisplayName = 'unknown user';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleSignIn()
        .then((FirebaseUser user) => print(user))
        .catchError((e) => print(e));
    if (user == null)
      userDisplayName = 'unknown user';
    else
      userDisplayName = user.displayName;
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
                  child: new Text(userDisplayName),
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