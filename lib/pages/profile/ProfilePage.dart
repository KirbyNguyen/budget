import 'package:budget/models/CustomUser.dart';
import 'package:budget/services/Validators.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final dynamic customUser;
  ProfilePage(this.customUser);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // key for signInForm to do validation
  final _profileKey = GlobalKey<FormState>();
  bool editableFields = false;

  // Input fields
  List<String> inputFields = ["", "", ""];
  @override
  Widget build(BuildContext context) {
    // Input fields
    List<String> initialValue = [
      widget.customUser.email,
      widget.customUser.firstName,
      widget.customUser.lastName,
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.10,
              vertical: 0.0),
          child: Form(
            key: _profileKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.people),
                    labelText: "First Name",
                  ),
                  enabled: editableFields,
                  initialValue: initialValue[1],
                  onChanged: (value) {
                    // setState(() => inputFields[1] = value);
                    inputFields[1] = value;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.people),
                    labelText: "Last Name",
                  ),
                  enabled: editableFields,
                  initialValue: initialValue[2],
                  onChanged: (value) {
                    // setState(() => inputFields[2] = value);
                    inputFields[2] = value;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                TextFormField(
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  validator: validateEmail,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: "Email",
                  ),
                  enabled: editableFields,
                  initialValue: initialValue[0],
                  onChanged: (value) {
                    // setState(() => inputFields[0] = value);
                    inputFields[0] = value;
                  },
                ),
                RaisedButton(
                  child: Text("EDIT"),
                  color: Colors.orange,
                  onPressed: () {
                    setState(() {
                      editableFields = !editableFields;
                    });
                  },
                ),
                RaisedButton(
                  child: Text("CONFIRM"),
                  onPressed: () {
                    print("Email: " + inputFields[0]);
                    print("First name: " + inputFields[1]);
                    print("Last name: " + inputFields[2]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
