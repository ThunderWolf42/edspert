import 'package:edspert/src/domain/repositories/auth_repository.dart';

class SignInWithGoogleUsecase {
  final AuthRepository repository;

  SignInWithGoogleUsecase(this.repository);

  Future<String?> call() {
    return repository.SignInWithGoogleUsecase();
  }
}
