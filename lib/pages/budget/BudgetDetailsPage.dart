import 'package:budget/models/Account.dart';
import 'package:budget/models/Category.dart';
import 'package:budget/models/Transaction.dart';
import 'package:budget/pages/transaction/list_item.dart';
import 'package:budget/services/AccountDatabaseServices.dart';
import 'package:budget/services/TransactionDatabaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BudgetDetailsPage extends StatefulWidget {
  final Category category;
  BudgetDetailsPage({this.category});

  @override
  _BudgetDetailsPageState createState() => _BudgetDetailsPageState();
}

class _BudgetDetailsPageState extends State<BudgetDetailsPage> {
  final TransactionDatabaseServices _transactionService =
      TransactionDatabaseServices();
  final AccountDatabaseSerivces _accountService = AccountDatabaseSerivces();

  List<UserTransaction> transactionList = [];
  List<ListItem> items = [];
  Map<String, Account> accounts = {};

  double _totalSpending = 0;

  void sortTransactionList() {
    transactionList.sort((a, b) => b.date.compareTo(a.date));
  }

  Future<void> getData() async {
    User user = FirebaseAuth.instance.currentUser;

    double totalSpending = 0;

    dynamic resultAccount = await _accountService.getAccounts(user.uid);
    if (resultAccount != null) {
      setState(() {
        for (int i = 0; i < resultAccount.length; i++) {
          accounts[resultAccount[i].id] = resultAccount[i];
        }
      });
    }

    dynamic resultTransaction =
        await _transactionService.getTransactionsByCategory(widget.category.id);

    if (resultTransaction != null) {
      setState(() {
        transactionList = resultTransaction;
      });
    }

    for (int i = 0; i < transactionList.length; i++) {
      totalSpending +=
          (transactionList[i].type == 0 ? transactionList[i].amount : 0);
    }
    _totalSpending = totalSpending;
  }

  List<ListItem> populateItems() {
    return transactionList.map((transaction) {
      return DetailedItem(
        // need to save purchase name to DB to get it out
        categoryName: widget.category.name,
        amount: transaction.amount,
        catColor: Color(widget.category.colors),
        accountColor: Color(accounts[transaction.accountid].color),
        type: transaction.type,
        date: transaction.date,
        id: transaction.id,
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    sortTransactionList();
    items = populateItems();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        actions: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(
                  "Budget: " + widget.category.budget.toString(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(
                  "Total Spending: " + _totalSpending.toString(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(
                  "Leftover: " +
                      (widget.category.budget - _totalSpending).toString(),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return items[index].buildItem(context);
          },
        ),
      ),
    );
  }
}
