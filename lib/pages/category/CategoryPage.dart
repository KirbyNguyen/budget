import 'package:budget/models/Account.dart';
import 'package:budget/models/Category.dart';
import 'package:budget/pages/transaction/list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:budget/services/AccountDatabaseServices.dart';
import 'package:flutter/material.dart';
import 'package:budget/pages/category/AddNewCategoryPage.dart';
// import '../transaction/list_item.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Category> transactionList = [];
  // Authentication service
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Category Page'),
        ),
      ),
    );
  }
}
