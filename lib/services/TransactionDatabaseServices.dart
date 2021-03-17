import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

extension DateTimeExtension on DateTime {
  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}

class TransactionDatabaseServices {
  final CollectionReference transactionCollection =
      FirebaseFirestore.instance.collection('TRANSACTIONS');

  // Setting an account for the user
  Future<void> setTransaction(String uid, String categoryName, double amount,
      DateTime date, TimeOfDay time) async {
    final dateTime = date.applied(time);
    try {
      return transactionCollection.doc().set({
        'uid': uid,
        'categoryName': categoryName,
        'amount': amount,
        'datetime': dateTime,
      });
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
