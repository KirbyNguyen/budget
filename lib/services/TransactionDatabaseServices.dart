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
  Future<void> setTransaction(
      String uid,
      String accountid,
      String categoryid,
      TransactionType type,
      String note,
      double amount,
      DateTime date,
      TimeOfDay time) async {
    DateTime dateTime = date.applied(time);

    try {
      return transactionCollection.doc().set({
        'uid': uid,
        'accountid': accountid,
        'categoryid': categoryid,
        'type': type == TransactionType.expense ? 0 : 1,
        'note': note,
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
            uid: document['uid'],
            id: document.id,
            accountid: document['accountid'],
            categoryid: document['categoryid'],
            type: document['type'],
            amount: document['amount'],
            note: document['note'],
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

  // Retrieve transaction
  Future<dynamic> getTransaction(String id) async {
    try {
      DocumentSnapshot document = await transactionCollection.doc(id).get();

      UserTransaction transaction = new UserTransaction(
        uid: document['uid'],
        id: document.id,
        accountid: document['accountid'],
        categoryid: document['categoryid'],
        type: document['type'],
        amount: document['amount'],
        note: document['note'],
        date: document['datetime'].toDate(),
      );

      return transaction;
    } catch (error) {
      print(error);
      return null;
    }
  }

  // Retrieve transaction
  Future<dynamic> getTransactionsByCategory(String id) async {
    List<UserTransaction> transactionList = [];
    try {
      QuerySnapshot eventsQuery =
          await transactionCollection.where("categoryid", isEqualTo: id).get();

      eventsQuery.docs.forEach(
        (document) {
          UserTransaction temp = new UserTransaction(
            uid: document['uid'],
            id: document.id,
            accountid: document['accountid'],
            categoryid: document['categoryid'],
            type: document['type'],
            amount: document['amount'],
            note: document['note'],
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

  Future<dynamic> editTransaction(
      String id,
      TransactionType type,
      String categoryId,
      String note,
      double amount,
      DateTime date,
      TimeOfDay time) async {
    DateTime dateTime = date.applied(time);
    try {
      DocumentReference document = transactionCollection.doc(id);

      await document.update({
        "type": type == TransactionType.expense ? 0 : 1,
        "categoryid": categoryId,
        "note": note,
        "amount": amount,
        "datetime": dateTime,
      });
    } catch (error) {
      print(error);
      return null;
    }
  }

  // Delete transaction
  Future<dynamic> deleteTransaction(String id) async {
    try {
      await transactionCollection.doc(id).delete();
    } catch (error) {
      print(error);
      return null;
    }
  }
}
