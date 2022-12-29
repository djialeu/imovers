import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:newimovers/repositories/repositories.dart';
import 'package:newimovers/services/authentication/authentication.dart';
import 'auth.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  final AuthenticationService authenticationService;

  AuthenticationBloc({
    required this.userRepository,
    required this.authenticationService
  });

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepository.hasToken();
      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.persistToken(event.token);
      await userRepository.persistUsername(event.username);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      // await authenticationService.signOut();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}