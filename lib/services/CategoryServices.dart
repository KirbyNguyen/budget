import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:budget/pages/category/AddNewCategoryPage.dart';
import 'package:budget/models/Category.dart';

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

// Retrieve categories that belong to the user
  Future<dynamic> getCategories(uid) async {
    List<Category> categoryList = [];
    try {
      QuerySnapshot eventsQuery =
          await transactionCollection.where("uid", isEqualTo: uid).get();
      eventsQuery.docs.forEach(
        (document) {
          Category temp = new Category(
              name: document['categoryName'],
              budget: document['categoryBudget'],
              uid: document['userid'],
              colors: document['Colors']);
          categoryList.add(temp);
        },
      );
      return categoryList;
    } catch (error) {
      print(error);
      return null;
    }
  }

  // Retrieve transaction
  Future<dynamic> getTransaction(String id) async {
    try {
      DocumentSnapshot document = await transactionCollection.doc(id).get();

      Category transaction = new Category(
        name: document['categoryName'],
        budget: document['categoryBudget'],
        uid: document['userid'],
        colors: document['Colors'],
      );

      return transaction;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
