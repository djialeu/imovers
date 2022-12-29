import 'dart:async';
import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';


import 'package:newimovers/repositories/repo.dart';
import 'package:newimovers/services/authentication/authentication.dart';
import 'package:newimovers/services/message/database.dart';
import '../auth_bloc/auth.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationService authenticationService;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    required this.userRepository,
    required this.authenticationBloc,
    required this.authenticationService
  });

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      log("Login processing");
      yield LoginLoading();

      try {
        final token = await userRepository.login(
          event.login,
          event.password,
        );
        authenticationBloc.add(LoggedIn(token: token!.access_token! , username: event.login));

        yield LoginInitial();
      } catch (error) {
        log( "Login Failed ${error}Login Failed");
        yield LoginFailure(error: error.toString());
      }
    }
    if(event is RegisterButtonPressed){
      log("Register processing");
      yield LoginLoading();

      try {

        final result = await userRepository.register(
          event.name,
          event.login,
          event.email,
          event.password,
        );
        await Database(result!.username).saveUser(result);
        print("Checking level error3");
        if(result != null){
          print("Etape login");
          final token = await userRepository.login(
            event.login,
            event.password,
          );
          authenticationBloc.add(LoggedIn(token: token!.access_token!, username: event.login));

          yield LoginInitial();
        }

      } catch (error) {
        log( "Register Failed ${error}Register Failed");
        yield LoginFailure(error: error.toString());
      }
    }
  }
}