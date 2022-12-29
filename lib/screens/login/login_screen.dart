import 'package:newimovers/services/authentication/authentication.dart';

import '../../blocs/auth_bloc/auth.dart';
import '../../blocs/login_bloc/login_bloc.dart';
import 'package:newimovers/repositories/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;
  final AuthenticationService authenticationService;

  LoginScreen({Key? key,required this.userRepository , required this.authenticationService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
            authenticationService: authenticationService
          );
        },
        child: LoginForm(userRepository: userRepository,),
      ),
    );
  }
}