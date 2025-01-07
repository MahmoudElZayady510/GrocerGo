

import '../../../data/auth/repository/auth_repository.dart';

class LogoutUserUsecase {
  final AuthRepository repository;

  LogoutUserUsecase(this.repository);

  Future<void> call() {
    return repository.logout();
  }
}
