import 'package:budget/models/LoadingIcon.dart';
import 'package:budget/services/AccountDatabaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  // key for signInForm to do validation
  final _accountKey = GlobalKey<FormState>();
  // Account Services
  AccountDatabaseSerivces _accountService = AccountDatabaseSerivces();

  // Data for the account
  bool _loading = false;
  String _accountName = "";
  String _balance = "";
  String _type = "";

  Color pickerColor = Color(0xff443a49);
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new account"),
      ),
      body: Center(
        child: Form(
          key: _accountKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.wallet_giftcard),
                  labelText: "Account Name",
                ),
                onChanged: (value) {
                  setState(() => _accountName = value);
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.money),
                  labelText: "Balance",
                ),
                onChanged: (value) {
                  setState(() => _balance = value);
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.money),
                  labelText: "Type",
                ),
                onChanged: (value) {
                  setState(() => _type = value);
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        titlePadding: const EdgeInsets.all(0.0),
                        contentPadding: const EdgeInsets.all(0.0),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: pickerColor,
                            onColorChanged: changeColor,
                            colorPickerWidth: 300.0,
                            pickerAreaHeightPercent: 0.7,
                            enableAlpha: true,
                            displayThumbColor: true,
                            showLabel: true,
                            paletteType: PaletteType.hsv,
                            pickerAreaBorderRadius: const BorderRadius.only(
                              topLeft: const Radius.circular(2.0),
                              topRight: const Radius.circular(2.0),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Text("Pick Color"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(pickerColor),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              ElevatedButton(
                child: loadingIcon(_loading, "ADD A NEW ACCOUNT"),
                onPressed: () async {
                  if (_accountKey.currentState.validate()) {
                    setState(() => _loading = true);
                    await _accountService.setAccount(
                      user.uid,
                      _accountName,
                      double.parse(_balance),
                      _type,
                      pickerColor.value,
                    );
                    setState(() => _loading = false);
                    // Move to home page
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
