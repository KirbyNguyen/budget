import 'package:budget/models/Category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CategoryServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection('CATEGORIES');

  Future<void> addCategory(
      String categoryName, double categoryBudget, int colors) async {
    User user = auth.currentUser;
    try {
      return categoryCollection.doc().set({
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

  Future<dynamic> getCategories(uid) async {
    List<Category> categoryList = [];

    try {
      QuerySnapshot eventsQuery =
          await categoryCollection.where("userid", isEqualTo: uid).get();

      eventsQuery.docs.forEach(
        (document) {
          Category temp = new Category(
            id: document.id,
            uid: document["userid"],
            name: document["categoryName"],
            budget: document["categoryBudget"],
            colors: document["Colors"],
          );
          categoryList.add(temp);
        },
      );

      // print(categoryList[0].id);
      return categoryList;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<dynamic> getCategory(String id) async {
    try {
      DocumentSnapshot document = await categoryCollection.doc(id).get();

      Category category = new Category(
        id: document.id,
        uid: document["userid"],
        name: document["categoryName"],
        budget: document["categoryBudget"],
        colors: document["Colors"],
      );

      return category;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<dynamic> editCategory(
      String id, String name, double budget, int colors) async {
    try {
      DocumentReference document = categoryCollection.doc(id);

      await document.update({
        "categoryName": name,
        "Colors": colors,
        "budget": budget,
      });
    } catch (error) {
      print(error);
      return null;
    }
  }

  // Delete transaction
  Future<dynamic> deleteCategory(String id) async {
    try {
      await categoryCollection.doc(id).delete();
    } catch (error) {
      print(error);
      return null;
    }
  }
}
