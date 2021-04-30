import 'package:budget/models/Category.dart';
import 'package:budget/models/Transaction.dart';
import 'package:budget/pages/transaction/EditTransactionPage.dart';
import 'package:budget/pages/transaction/NewTransactionPage.dart';
import 'package:budget/services/AccountDatabaseServices.dart';
import 'package:budget/services/CategoryServices.dart';
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
  Category category;
  // Transaction information
  final TransactionDatabaseServices _transactionService =
      TransactionDatabaseServices();
  // Account service
  final AccountDatabaseSerivces _accountService = AccountDatabaseSerivces();
  // Category service
  final CategoryServices _categoryService = CategoryServices();

  // Map<String, Color> categories = {
  //   'Groceries': Colors.red,
  //   'Gas': Colors.purple,
  //   'Work Lunches': Colors.blue,
  //   'Take Outs': Colors.yellow,
  // };

  void getData() async {
    dynamic transactionResult =
        await _transactionService.getTransaction(widget.transactionId);
    if (transactionResult != null) {
      setState(
        () {
          transaction = transactionResult;
        },
      );
    }
    dynamic categoryResult =
        await _categoryService.getCategory(transaction.categoryid);
    if (transactionResult != null) {
      setState(
        () {
          category = categoryResult;
        },
      );
    }
  }

  Future<bool> _showMyDialog() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You are about to delete this transaction'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                await _accountService.editAccount(
                  transaction.accountid,
                  transaction.amount,
                  transaction.type == 0
                      ? TransactionType.income
                      : TransactionType.expense,
                );

                await _transactionService.deleteTransaction(transaction.id);

                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
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
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                transaction.date.toString().substring(0, 16),
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Category: ",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          category.name,
                          style: TextStyle(
                            color: Color(category.colors),
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      transaction.type == 0 ? "Expense" : "Income",
                      style: TextStyle(
                        color:
                            transaction.type == 0 ? Colors.red : Colors.green,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      transaction.amount.toString(),
                      style: TextStyle(
                        color:
                            transaction.type == 0 ? Colors.red : Colors.green,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Note: ",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          transaction.note,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTransactionPage(
                              transactionId: transaction.id,
                              accountId: transaction.accountid,
                              userId: transaction.uid,
                              existingTime: transaction.date,
                              type: transaction.type,
                            ),
                          ),
                        );
                      },
                      child: Text("EDIT"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        side: BorderSide(color: Colors.black, width: 1),
                        minimumSize: Size(150, 50),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _showMyDialog().then((exit) {
                          if (!exit) {
                            Navigator.of(context).pop();
                          }
                        });
                      },
                      child: Text("DELETE"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        side: BorderSide(color: Colors.black, width: 1),
                        minimumSize: Size(150, 50),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
