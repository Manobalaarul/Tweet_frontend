part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthenticationEvent extends AuthEvent {
  final AuthType authType;
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  AuthenticationEvent({
    required this.authType,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });
}

