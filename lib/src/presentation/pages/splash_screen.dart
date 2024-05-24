import 'package:edspert/src/core/constants/color_constants.dart';
import 'package:edspert/src/presentation/pages/home_nav_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/auth/auth_bloc.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Size size;

  @override
  void didChangeDependencies() {
    size = MediaQuery.sizeOf(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // Future.delayed(const Duration(seconds: 3))
    //     .then((value) => Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => const LoginScreen(),
    //         )));
    context.read<AuthBloc>().add(IsSignedInWithGoogleEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (AuthState prevState, AuthState nextState) =>
          prevState is IsSignedInWithGoogleLoading &&
          (nextState is IsSignedInWithGoogleSuccess ||
              nextState is IsSignedInWithGoogleError),
      listener: (context, state) {
        if (state is IsSignedInWithGoogleSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeNavScreen(),
            ),
          );
        }

        if (state is IsSignedInWithGoogleError) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.edspertBlue,
        body: Center(
          child: Image.asset(
            'images/edspert_logo.png',
            width: size.width * 0.5,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
