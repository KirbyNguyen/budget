import 'package:budget/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:budget/services/AuthenticationServices.dart';
import 'package:budget/services/Validators.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.10,
          MediaQuery.of(context).size.height * 0.10,
          MediaQuery.of(context).size.width * 0.10,
          MediaQuery.of(context).size.height * 0.03,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SignUpForm(),
          ],
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  List<String> inputFields = ["", "", ""];
  // AuthService for signing in
  final AuthService _auth = AuthService();
  // key for signInForm to do validation
  final _signUpKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signUpKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          TextFormField(
            textCapitalization: TextCapitalization.none,
            autocorrect: false,
            validator: validateEmail,
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              labelText: "Email",
            ),
            onChanged: (value) {
              setState(() => inputFields[0] = value);
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          TextFormField(
            textCapitalization: TextCapitalization.none,
            autocorrect: false,
            obscureText: true,
            validator: validatePassword,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: "Password",
            ),
            onChanged: (value) {
              setState(() => inputFields[1] = value);
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          TextFormField(
            textCapitalization: TextCapitalization.none,
            autocorrect: false,
            obscureText: true,
            validator: (value) =>
                validateConfirmPassword(value, inputFields[1]),
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: "Confirm Password",
            ),
            onChanged: (value) {
              setState(() => inputFields[2] = value);
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          RaisedButton(
            child: Text("SIGN UP"),
            onPressed: () async {
              if (_signUpKey.currentState.validate()) {
                dynamic result = await _auth.registerWithEmailAndPassword(
                    inputFields[0],
                    inputFields[1]);
                if (result != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                }
              }
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
        ],
      ),
    );
  }
}
