part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String login;
  final String password;

  const LoginButtonPressed({
    required this.login,
    required this.password,
  });

  @override
  List<Object> get props => [login, password];

  @override
  String toString() =>
      'LoginButtonPressed { email: $login, password: $password }';
}

class RegisterButtonPressed extends LoginEvent {
  final String email;
  final String login;
  final String name;
  final String password;

  const RegisterButtonPressed({
    required this.name,
    required this.email,
    required this.login,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'RegisterButtonPressed { email: $email, login: $login, password: $password }';
}