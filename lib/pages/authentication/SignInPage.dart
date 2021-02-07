import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.10,
          MediaQuery.of(context).size.height * 0.10,
          MediaQuery.of(context).size.width * 0.10,
          MediaQuery.of(context).size.height * 0.03,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[],
        ),
      ),
    );
  }
}