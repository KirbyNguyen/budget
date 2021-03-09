import 'package:budget/pages/accounts/CreateAccountPage.dart';
import 'package:flutter/material.dart';

class AccountsPage extends StatefulWidget {
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accounts"),
      ),
      body: Container(
        child: Center(
          child: TextButton(
            child: Text("Add a new account"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateAccountPage()),
              );
            },
          ),
        ),
      ),
    );
  }
}
