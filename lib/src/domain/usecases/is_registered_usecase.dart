import '../repositories/auth_repository.dart';

class IsRegisteredUsecase {
  final AuthRepository repository;

  IsRegisteredUsecase(this.repository);

  Future<bool> call(String email) {
    return repository.IsRegisteredUsecase(email);
  }
}
