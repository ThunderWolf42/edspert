import 'package:edspert/src/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<bool> call() {
    return repository.RegisterUsecase();
  }
}
