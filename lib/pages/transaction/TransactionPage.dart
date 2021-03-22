import 'package:budget/models/Account.dart';
import 'package:budget/models/Transaction.dart';
import 'package:budget/services/AccountDatabaseServices.dart';
import 'package:budget/services/TransactionDatabaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'NewTransactionPage.dart';
// import 'list_item.dart';
// import 'package:budget/pages/accounts/AccountPage.dart';
// import 'package:budget/pages/transaction/AllTransactionPage.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
// Build list of items based on their types: date items and purchase items
// based on chronological order
// 2 types of ListItem: DateItem(String date) for the date category
//                      PurchaseItem(String name, Double amount, Color color)
// also get the sum of all spending this month
  List<UserTransaction> transactionList = [];
  // Authentication service
  final FirebaseAuth auth = FirebaseAuth.instance;
  // Transaction information
  final TransactionDatabaseServices _transactionService =
      TransactionDatabaseServices();
  // Account service
  final AccountDatabaseSerivces _accountService = AccountDatabaseSerivces();
  Map<String, Account> accounts = {};
  Map<String, Color> categories = {
    'Groceries': Colors.red,
    'Gas': Colors.purple,
    'Work Lunches': Colors.blue,
    'Take Outs': Colors.yellow,
  };

  // Get transaction data and put them in the list
  void getData() async {
    User user = auth.currentUser;

    // Get transaction
    dynamic resultAccount = await _accountService.getAccounts(user.uid);
    if (resultAccount != null) {
      setState(() {
        for (int i = 0; i < resultAccount.length; i++) {
          accounts[resultAccount[i].id] = resultAccount[i];
        }
      });
    }

    // Get account
    dynamic resultTransaction =
        await _transactionService.getTransactions(user.uid);
    if (resultTransaction != null) {
      setState(() {
        transactionList = resultTransaction;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    print('TransactionPage->initState() ran ');
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    print('TransactionPage->build() ran');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: Row(
          children: [
            Expanded(
              flex: 8,
              child: Text(
                'Period Spending Total',
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                '12345.67',
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue[900],
        child: Container(
          child: Icon(
            Icons.add,
            size: 40.0,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyCustomForm()),
          );
        },
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: transactionList.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      Color(accounts[transactionList[index].accountid].color),
                  width: 5.0,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              margin: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 5.0),
                  Text(transactionList[index].date.toString()),
                  SizedBox(height: 5.0),
                  Text(
                    transactionList[index].category,
                    style: TextStyle(
                        color: categories[transactionList[index].category]),
                  ),
                  SizedBox(height: 5.0),
                  Text(transactionList[index].amount.toString()),
                  SizedBox(height: 5.0),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
