import '../repositories/auth_repository.dart';

class IsSignedInWithGoogleUsecase {
  final AuthRepository repository;

  IsSignedInWithGoogleUsecase(this.repository);

  bool call() {
    return repository.IsSignedInWithGoogleUsecase();
  }
}
