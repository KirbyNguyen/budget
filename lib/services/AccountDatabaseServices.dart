import 'package:budget/models/Account.dart';
import 'package:budget/pages/transaction/NewTransactionPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountDatabaseSerivces {
  // Getting access to the firebase collect "USERS"
  final CollectionReference accountCollection =
      FirebaseFirestore.instance.collection('ACCOUNTS');

  // Setting an account for the user
  Future<void> setAccount(
      String uid, String name, double balance, String type, int color) async {
    try {
      return accountCollection.doc().set({
        'uid': uid,
        'name': name,
        'balance': balance,
        'type': type,
        'color': color
      });
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Edit an account
  Future<void> editAccount(String id, double transaction, Type type) async {
    Account account;
    try {
      DocumentSnapshot document = await accountCollection.doc(id).get();
      account = Account(
        balance: document["balance"],
        color: document["color"],
        name: document["name"],
        type: document["type"],
        uid: document["uid"],
        id: document.id,
      );
      await accountCollection.doc(id).set({
        'uid': account.uid,
        'name': account.name,
        'balance': type == Type.expense
            ? account.balance - transaction
            : account.balance + transaction,
        'type': account.type,
        'color': account.color
      });
      return account;
    } catch (error) {
      print(error);
      return null;
    }
  }

  // Retrieve accounts belong to the user
  Future<dynamic> getAccounts(uid) async {
    List<Account> accountList = [];
    try {
      QuerySnapshot eventsQuery =
          await accountCollection.where("uid", isEqualTo: uid).get();
      eventsQuery.docs.forEach(
        (document) {
          Account temp = new Account(
            balance: document["balance"],
            color: document["color"],
            name: document["name"],
            type: document["type"],
            uid: document["uid"],
            id: document.id,
          );
          accountList.add(temp);
        },
      );
      return accountList;
    } catch (error) {
      print(error);
      return null;
    }
  }

  // A function to get user information

}
