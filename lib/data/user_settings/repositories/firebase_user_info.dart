import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceries/data/user_settings/repositories/user_info.dart';
import 'package:groceries/domain/user_settings/models/User_info.dart';

class FirebaseUserInfoRepository implements UserInfoRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  FirebaseUserInfoRepository(this._firestore, this._firebaseAuth);

  String get userId => _firebaseAuth.currentUser!.uid;

  @override
  Stream<UserData?> getUserInfo() {
    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((docSnapshot) {
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>?;
        return UserData(
            id: docSnapshot.id,
            email: data?['email'] ?? 'noemail', // Fallback to 'noemail' if null
            firstName: data?['firstName'] ?? 'noFName',
            lastName: data?['lastName'] ?? 'noLName',
            address: data?['address'] ?? 'noAddress'
            // image: data?['image'] ?? 'noimage' // Fallback to 'noimage' if null
            );
        //bad code
      } else {
        // If the document doesn't exist, return null
        return null;
      }
    });
  }
}
