import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseService {
  // Getting access to the firebase collect "USERS"
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('USERS');

  // Setting email, first name, and last name inside the user collection
  Future setUser(
      String uid, String email, String firstName, String lastName) async {
    try {
      return userCollection
          .doc(uid)
          .set({'email': email, 'firstName': firstName, 'lastName': lastName});
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
