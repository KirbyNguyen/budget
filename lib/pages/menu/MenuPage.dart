import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budget/pages/profile/ProfilePage.dart';
import 'package:budget/pages/accounts/AccountPage.dart';
import 'package:budget/services/UserDatabaseServices.dart';
import 'package:budget/services/AuthenticationServices.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // Authentication services
  final AuthService _auth = AuthService();
  // User services
  final UserDatabaseService _userService = UserDatabaseService();
  @override
  Widget build(BuildContext context) {
    // Getting user's id
    final user = Provider.of<User>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  child: Text("Profile"),
                  onTap: () async {
                    dynamic customUserData =
                        await _userService.getUser(user.uid);
                    if (customUserData != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(customUserData),
                        ),
                      );
                    }
                  },
                ),
              ),
              Divider(
                thickness: 2.0,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  child: Text("Accounts"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountsPage(),
                      ),
                    );
                  },
                ),
              ),
              Divider(
                thickness: 2.0,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              RaisedButton(
                child: Text("Sign Out"),
                onPressed: () {
                  _auth.signOut();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
