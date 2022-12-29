import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final String token , username;

  const LoggedIn({required this.token, required this.username});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoggedIn { token: $token\n username:  $username }';
}

class LoggedOut extends AuthenticationEvent {}