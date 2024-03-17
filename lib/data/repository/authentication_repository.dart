import 'dart:io';

import 'package:cinemax/data/datasource/authentication.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<String, String>> register(
      String email, String name, String password, String passwordConfirm);

  Future<Either<String, String>> login(String password, String identity);
  Future<Either<String, String>> updateData(File image, String id);
}

class AuthenticationRemoteRepo extends AuthenticationRepository {
  final AuthenticationDatasource _datasource;

  AuthenticationRemoteRepo(this._datasource);

  @override
  Future<Either<String, String>> register(String email, String name,
      String password, String passwordConfirm) async {
    try {
      await _datasource.register(email, name, password, passwordConfirm);
      return right("You successfully signed up!");
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, String>> login(String password, String identity) async {
    try {
      var token = await _datasource.login(password, identity);
      if (token.isNotEmpty) {
        return right("You successfully logged in!");
      } else {
        return left("Error in logging in");
      }
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, String>> updateData(File image, String id) async {
    try {
      String response = await _datasource.updateData(image, id);
      if (response.isNotEmpty) {
        return right("Update was successful");
      } else {
        return left("empty");
      }
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }
}
