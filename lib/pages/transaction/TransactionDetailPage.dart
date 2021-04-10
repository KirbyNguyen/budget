import 'package:budget/models/Transaction.dart';
import 'package:budget/services/AccountDatabaseServices.dart';
import 'package:budget/services/TransactionDatabaseServices.dart';
import 'package:flutter/material.dart';

class TransactionDetailPage extends StatefulWidget {
  final String transactionId;

  TransactionDetailPage({Key key, @required this.transactionId})
      : super(key: key);

  @override
  _TransactionDetailPageState createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  UserTransaction transaction;
  // Transaction information
  final TransactionDatabaseServices _transactionService =
      TransactionDatabaseServices();
  // Account service
  final AccountDatabaseSerivces _accountService = AccountDatabaseSerivces();

  void getData() async {
    dynamic result =
        await _transactionService.getTransaction(widget.transactionId);
    if (result != null) {
      setState(
        () {
          transaction = result;
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(transaction.date.toString().substring(0, 16)),
            Text(transaction.category.toString()),
            Text(transaction.type == 0 ? "Expense" : "Income"),
            Text(transaction.amount.toString()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {},
                  child: Text("EDIT"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("DELETE"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
