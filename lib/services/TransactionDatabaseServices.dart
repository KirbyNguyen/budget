import 'package:budget/models/Transaction.dart';
import 'package:budget/pages/transaction/NewTransactionPage.dart';
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
  Future<void> setTransaction(String uid, String accountid, Type type,
      String categoryName,
      double amount, DateTime date, TimeOfDay time) async {
    DateTime dateTime = date.applied(time);
    try {
      return transactionCollection.doc().set({
        'uid': uid,
        'accountid': accountid,
        'type': type,
        'categoryName': categoryName,
        'amount': amount,
        'datetime': dateTime,
      });
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Retrieve transactions belong to the user
  Future<dynamic> getTransactions(uid) async {
    List<UserTransaction> transactionList = [];
    try {
      QuerySnapshot eventsQuery =
          await transactionCollection.where("uid", isEqualTo: uid).get();
      eventsQuery.docs.forEach(
        (document) {
          UserTransaction temp = new UserTransaction(
            accountid: document['accountid'],
            uid: document['uid'],
            id: document.id,
            amount: document['amount'],
            category: document['categoryName'],
            date: document['datetime'].toDate(),
          );
          transactionList.add(temp);
        },
      );
      return transactionList;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
