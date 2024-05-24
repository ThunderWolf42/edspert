import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:edspert/src/domain/usecases/is_signed_in_with_google_usecase.dart';
import 'package:edspert/src/domain/usecases/sign_in_with_google_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IsSignedInWithGoogleUsecase isSignedInWithGoogleUsecase;
  final SignInWithGoogleUsecase signInWithGoogleUsecase;

  AuthBloc(this.isSignedInWithGoogleUsecase, this.signInWithGoogleUsecase) : super(AuthInitialState()) {
    on<AuthEvent>((event, emit) async {
      if (event is IsSignedInWithGoogleEvent) {
        emit(IsSignedInWithGoogleLoading());

        bool isSignedIn = isSignedInWithGoogleUsecase();
        await Future.delayed(const Duration(seconds: 3));
        if (isSignedIn) {
          emit(IsSignedInWithGoogleSuccess());
          return;
        }
        emit(IsSignedInWithGoogleError());
      }

      if (event is SignInWithGoogleEvent) {
        emit(SignInGoogleLoading());

        String? email = await signInWithGoogleUsecase();
        if (email != null) {
          emit(SignInGoogleSuccess(email));
          return;
        }
        emit(SignInGoogleError('Error signin...'));
      }
    });
  }
}
