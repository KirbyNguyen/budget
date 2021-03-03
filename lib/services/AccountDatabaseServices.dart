import 'package:cloud_firestore/cloud_firestore.dart';

class AccountDatabaseSerivces {
  // Getting access to the firebase collect "USERS"
  final CollectionReference accountCollection =
      FirebaseFirestore.instance.collection('ACCOUNTS');

  // Setting an account for the user
  Future<void> setAccount(
      String uid, String name, double balance, String type, String color) async {
    try {
      return accountCollection
          .doc()
          .set({'uid': uid, 'name': name, 'balance': balance, 'type': type, 'color': color});
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // A function to get user information
  
}
