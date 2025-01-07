import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/auth/repository/auth_repository.dart';

class SignUpUseCase  {
  final AuthRepository repository;

  SignUpUseCase (this.repository);

  // Future<void> call(String email, String password, String username) async {
  Future<void> call(String email, String password , String firstName , String lastName) async {
    try {
      final user = await repository.signUp(email, password);
      print(user);
      if (user != null) {
        await repository.createUserDocument(user.uid, {
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      throw Exception('Error during sign-up: $e');
    }
  }
  // Future<User?> call(String email, String password) {
  //   return repository.signUp(email, password);
  // }
}
