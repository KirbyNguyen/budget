import 'package:budget/models/Account.dart';
import 'package:budget/pages/accounts/CreateAccountPage.dart';
import 'package:budget/services/AccountDatabaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AccountsPage extends StatefulWidget {
  final dynamic customUser;
  AccountsPage(this.customUser);

  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  // Account Services
  final FirebaseAuth auth = FirebaseAuth.instance;
  final AccountDatabaseSerivces _accountService = AccountDatabaseSerivces();
  List<Account> _accounts;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => getAccounts());
  }

  Future<List<Account>> getAccounts() async {
    User user = auth.currentUser;
    dynamic result = await _accountService.getAccounts(user.uid);
    setState(() {
      _accounts = result;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accounts"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              child: Text("Add a new account"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateAccountPage(),
                  ),
                );
              },
            ),
            Expanded(
              child: _accounts != null
                  ? ListView.builder(
                      itemCount: _accounts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Color(_accounts[index].color),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(_accounts[index].name),
                                subtitle: Text(_accounts[index].type),
                              ),
                              Text("Balance: " +
                                  _accounts[index].balance.toString()),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text("There is an error"),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
