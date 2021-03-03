import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budget/models/CustomUser.dart';

class UserDatabaseService {
  // Getting access to the firebase collect "USERS"
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('USERS');

  // Setting email, first name, and last name inside the user collection
  Future<void> setUser(
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

  // A function to get user information
  Future<CustomUser> getUser(String uid) async {
    DocumentSnapshot userSnapshot = await userCollection.doc(uid).get();
    try {
      String email = userSnapshot.data()['email'];
      String firstName = userSnapshot.data()['firstName'];
      String lastName = userSnapshot.data()['lastName'];
      CustomUser customUser = CustomUser(
        email: email,
        firstName: firstName,
        lastName: lastName,
      );
      return customUser;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
