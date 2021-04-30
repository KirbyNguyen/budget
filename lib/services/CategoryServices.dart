import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CategoryServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference transactionCollection =
      FirebaseFirestore.instance.collection('CATEGORIES');

  Future<void> addCategory(
      String categoryName, double categoryBudget, int colors) async {
    User user = auth.currentUser;
    try {
      return transactionCollection.doc().set({
        'categoryName': categoryName,
        'categoryBudget': categoryBudget,
        'Colors': colors,
        'userid': user.uid
      });
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
