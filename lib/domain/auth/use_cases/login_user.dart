import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/auth/repository/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<User?> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
