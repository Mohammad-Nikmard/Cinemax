import 'package:dartz/dartz.dart';

abstract class AuthState {}

class AuthInitState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthRegisterResponseState extends AuthState {
  Either<String, String> response;

  AuthRegisterResponseState(this.response);
}

class AuthLoginResponseState extends AuthState {
  Either<String, String> response;

  AuthLoginResponseState(this.response);
}
