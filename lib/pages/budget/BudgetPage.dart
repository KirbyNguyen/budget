import 'package:budget/models/Account.dart';
import 'package:budget/models/Category.dart';
import 'package:budget/models/Transaction.dart';
import 'package:budget/pages/budget/BudgetDetailsPage.dart';
import 'package:budget/pages/category/AddNewCategoryPage.dart';
import 'package:budget/services/AccountDatabaseServices.dart';
import 'package:budget/services/CategoryServices.dart';
import 'package:budget/services/TransactionDatabaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BudgetPage extends StatefulWidget {
  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  // Authentication service
  final FirebaseAuth auth = FirebaseAuth.instance;
  // Transaction information
  final TransactionDatabaseServices _transactionService =
      TransactionDatabaseServices();
  // Account service
  final AccountDatabaseSerivces _accountService = AccountDatabaseSerivces();
  // Category service
  final CategoryServices _categoryService = CategoryServices();

  List<UserTransaction> transactionList = [];
  List<Category> categoryList = [];
  Map<String, Account> accounts = {};
  Map<String, Category> categories = {};

  Future<void> getData() async {
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

    dynamic resultCategory = await _categoryService.getCategories(user.uid);
    if (resultCategory != null) {
      setState(() {
        categoryList = resultCategory;
        for (int i = 0; i < resultCategory.length; i++) {
          categories[resultCategory[i].id] = resultCategory[i];
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
  }

  @override
  Widget build(BuildContext context) {
    getData();
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: Text("Budget"),
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
            MaterialPageRoute(builder: (context) => AddNewCategoryPage()),
          );
        },
      ),
      body: ListView.builder(
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BudgetDetailsPage(
                          category: categoryList[index],
                        ),
                      ),
                    );
                  },
                  title: Text(
                    categoryList[index].name,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Color(categoryList[index].colors),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
