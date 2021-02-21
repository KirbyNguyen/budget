import 'package:budget/pages/HomePage.dart';
import 'package:budget/services/AuthenticationServices.dart';
import 'package:flutter/material.dart';
import 'package:budget/pages/authentication/SignUpPage.dart';
import 'package:budget/services/Validators.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SignInForm(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Don't have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ),
                    );
                  },
                  child: Text("SIGN UP"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  List<String> inputFields = ["", ""];
  // AuthService for signing in
  final AuthService _auth = AuthService();
  // key for signInForm to do validation
  final _signInKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signInKey,
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
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: GestureDetector(
              child: Text("RESET PASSWORD"),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          RaisedButton(
            child: Text("SIGN In"),
            onPressed: () async {
              if (_signInKey.currentState.validate()) {
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
