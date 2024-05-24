import 'package:edspert/src/data/data_source/auth_data_source.dart';
import 'package:edspert/src/data/repositories/auth_repository_impl.dart';
import 'package:edspert/src/data/repositories/profile_repository_impl.dart';
import 'package:edspert/src/domain/repositories/auth_repository.dart';

import 'package:edspert/src/domain/usecases/is_signed_in_with_google_usecase.dart';
import 'package:edspert/src/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:edspert/src/domain/usecases/upload_image_usecase.dart';
import 'package:edspert/src/presentation/manager/auth/auth_bloc.dart';
import 'package:edspert/src/presentation/manager/home_nav/home_nav_cubit.dart';
import 'package:edspert/src/presentation/manager/profile/profile_bloc.dart';
import 'package:edspert/src/presentation/pages/register_screen.dart';

import 'package:edspert/src/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            AuthDataSource authDataSource = AuthDataSource();
            AuthRepository authRepository = AuthRepositoryImpl(authDataSource);
            return AuthBloc(
              IsSignedInWithGoogleUsecase(authRepository),
              SignInWithGoogleUsecase(authRepository),
            );
          },
        ),
        BlocProvider(create: (context) => HomeNavCubit()),
        BlocProvider(
          create: (context) => ProfileBloc(
            UploadImageUsecase(
              ProfileRepositoryImpl(),
            ),
          ),
        )
      ],
      child:   const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: SplashScreen(),
      ),
    );
  }
}
