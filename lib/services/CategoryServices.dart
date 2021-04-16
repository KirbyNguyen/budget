import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryServices {
  final CollectionReference transactionCollection =
      FirebaseFirestore.instance.collection('CATEGORIES');

  Future<void> addCategory(
      String categoryName, int categoryBudget, Color colors) async {
    try {
      return transactionCollection.doc().set({
        'categoryName': categoryName,
        'categoryBudget': categoryBudget,
        'Colors': colors
      });
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
