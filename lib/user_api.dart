import 'package:cloud_firestore/cloud_firestore.dart';

class UserApi {
  static final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      final DocumentSnapshot snapshot =
          await _usersCollection.doc(userId).get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>?;
      }
      return null;
    } catch (e) {
      print('Failed to get user data: $e');
      return null;
    }
  }

  static Future<void> updateUserData(
      String userId, Map<String, dynamic> data) async {
    try {
      await _usersCollection.doc(userId).set(data, SetOptions(merge: true));
    } catch (e) {
      print('Failed to update user data: $e');
    }
  }
}
