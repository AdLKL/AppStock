import 'package:appstock/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:appstock/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:appstock/screens/auth/welcome_screen.dart';
import 'package:appstock/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Firebase Auth',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
              background: Colors.white,
              onBackground: Colors.black,
              primary: Color.fromARGB(255, 11, 165, 236),
              onPrimary: Colors.black,
              secondary: Color.fromARGB(255, 5, 164, 237),
              onSecondary: Colors.white,
              error: Color.fromARGB(255, 0, 130, 230),
              outline: Color(0xFF424242)),
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return BlocProvider(
              create: (context) => SignInBloc(
                  userRepository:
                      context.read<AuthenticationBloc>().userRepository),
              child: const HomeScreen(),
            );
          } else {
            return const WelcomeScreen();
          }
        }));
  }
}
