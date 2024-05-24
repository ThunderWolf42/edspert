 abstract class AuthRepository{
  Future<bool> IsRegisteredUsecase(String email);

  bool IsSignedInWithGoogleUsecase();

  Future<bool> RegisterUsecase();
  
  Future<String?> SignInWithGoogleUsecase();
}