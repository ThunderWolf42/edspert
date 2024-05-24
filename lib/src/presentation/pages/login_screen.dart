import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/auth/auth_bloc.dart';
import '../widgets/login_button.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset('images/login_logo.png'),
                const SizedBox(height: 56),
                const Text(
                  'Selamat Datang',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                ),
                const Text(
                  'Selamat Datang di Aplikasi Widya Edu\n'
                  'Aplikasi Latihan dan Konsultasi Soal',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6A7483),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                BlocConsumer<AuthBloc, AuthState>(
                  /// Listener
                  listenWhen: (prev, next) =>
                      prev is SignInGoogleLoading &&
                      (next is SignInGoogleError ||
                          next is SignInGoogleSuccess),
                  listener: (context, state) {
                    print('Listener: AuthBloc...');

                    if (state is SignInGoogleSuccess) {
                      print('Google Sign In Success: ${state.email}');
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                      );
                    }
                  },

                  /// Builder
                  buildWhen: (prev, next) =>
                      prev is SignInGoogleLoading &&
                      (next is SignInGoogleError ||
                          next is SignInGoogleSuccess),
                  builder: (context, state) {

                    if (state is SignInGoogleLoading) {
                      return const CircularProgressIndicator();
                    }

                    return LoginButton(
                      loginButtonVariant: LoginButtonVariant.google,
                      onPressed: () {
                        context.read<AuthBloc>().add(SignInWithGoogleEvent());
                      },
                    );
                  },
                ),
                const SizedBox(height: 12),
                LoginButton(
                  loginButtonVariant: LoginButtonVariant.apple,
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
