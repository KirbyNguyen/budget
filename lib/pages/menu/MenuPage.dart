import 'package:budget/services/AuthenticationServices.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // Authentication services
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Menu Page"),
            RaisedButton(
              child: Text("Sign Out"),
              onPressed: () {
                _auth.signOut();
              },
            )
          ],
        ),
      ),
    );
  }
}
