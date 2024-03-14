import 'package:dartz/dartz.dart';

abstract class AuthState {}

class AuthInitState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthRegisterResponseState extends AuthState {
  Either<String, String> registerRespnse;

  AuthRegisterResponseState(this.registerRespnse);
}

class AuthLoginResponseState extends AuthState {
  Either<String, String> loginResponse;

  AuthLoginResponseState(this.loginResponse);
}
