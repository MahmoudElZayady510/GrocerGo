import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/auth/repository/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<User?> call(String email, String password) {
    return repository.signUp(email, password);
  }
}
