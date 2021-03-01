import 'package:budget/models/LoadingIcon.dart';
import 'package:budget/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:budget/services/AuthenticationServices.dart';
import 'package:budget/services/UserDatabaseServices.dart';
import 'package:budget/services/Validators.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      // Showing the title of the screen
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      // Padding the screen
      body: Container(
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.10,
          MediaQuery.of(context).size.height * 0.10,
          MediaQuery.of(context).size.width * 0.10,
          MediaQuery.of(context).size.height * 0.03,
        ),
        // Showing the column
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Showing the sign in form
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
  List<String> inputFields = ["", "", "", "", ""];
  // AuthService for signing in
  final AuthService _auth = AuthService();
  final UserDatabaseService _userCollection = UserDatabaseService();
  // key for signInForm to do validation
  final _signUpKey = GlobalKey<FormState>();
  // loading
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signUpKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // First name field
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.people),
              labelText: "First Name",
            ),
            onChanged: (value) {
              setState(() => inputFields[3] = value);
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          // Last name field
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.people),
              labelText: "Last Name",
            ),
            onChanged: (value) {
              setState(() => inputFields[4] = value);
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          // Email field
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
          // Password
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
          // Password Confirmation field
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
            child: loadingIcon(_loading, "SIGN UP"),
            onPressed: () async {
              if (_signUpKey.currentState.validate()) {
                setState(() => _loading = true);
                dynamic result = await _auth.registerWithEmailAndPassword(
                    inputFields[0], inputFields[1]);
                if (result == null) {
                  print("ERROR");
                  print(result);
                }
                await _userCollection.setUser(
                  result.uid,
                  inputFields[0],
                  inputFields[3],
                  inputFields[4],
                );
                // Move to home page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(),
                  ),
                );
                setState(() => _loading = false);
              }
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
        ],
      ),
    );
  }
}
