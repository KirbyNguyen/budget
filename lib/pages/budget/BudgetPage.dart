import 'package:budget/models/Account.dart';
import 'package:budget/models/Transaction.dart';
import 'package:budget/services/AccountDatabaseServices.dart';
import 'package:budget/services/TransactionDatabaseServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BudgetPage extends StatefulWidget {
  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  CollectionReference transactions =
      FirebaseFirestore.instance.collection('transactions');
  // Authentication service
  final FirebaseAuth auth = FirebaseAuth.instance;
  // Transaction information
  final TransactionDatabaseServices _transactionService =
      TransactionDatabaseServices();
  // Account service
  final AccountDatabaseSerivces _accountService = AccountDatabaseSerivces();
  List<UserTransaction> transactionList = [];
  Map<String, Account> accounts = {};
  Map<String, List<UserTransaction>> categories = {};

  void getCategories() {
    String category;
    for (int i = 0; i < transactionList.length; i++) {
      category = transactionList[i].category;
      categories[category].add(transactionList[i]);
    }
  }

  // Get accounts and transaction data and put them in the list
  void getData() async {
    User user = auth.currentUser;

    // Get accounts
    dynamic resultAccount = await _accountService.getAccounts(user.uid);
    if (resultAccount != null) {
      setState(() {
        for (int i = 0; i < resultAccount.length; i++) {
          accounts[resultAccount[i].id] = resultAccount[i];
        }
      });
    }

    // Get transactions
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
  }

  @override
  Widget build(BuildContext context) {
    print('from budget page->build');

    // print(
    //     transactions.doc(firebaseUser.uid).get().then((value) => print(value)));
    // var q = transactions.where(
    //   'uid',
    //   isEqualTo: firebaseUser.uid,
    // );
    // print(firebaseUser.email);
    // print(transactions
    //     .where(
    //       'uid',
    //       isEqualTo: firebaseUser.uid,
    //     )
    //     .get()
    //     .then((value) {
    //   value.docs.forEach((element) {
    //     print(element.data());
    //   });
    // }));
    print('done');
    return Scaffold(
      body: Center(
        child: Text("Budget Pageeee"),
      ),
    );
  }
}
