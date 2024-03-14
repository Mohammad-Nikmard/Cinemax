import 'package:cinemax/util/api_exception.dart';
import 'package:cinemax/util/auth_manager.dart';
import 'package:dio/dio.dart';

abstract class AuthenticationDatasource {
  Future<void> register(
      String email, String name, String password, String passwordConfirm);

  Future<String> login(String password, String identity);
}

class AuthenticationRemoteDatasource extends AuthenticationDatasource {
  final Dio _dio;

  AuthenticationRemoteDatasource(this._dio);

  @override
  Future<void> register(String email, String name, String password,
      String passwordConfirm) async {
    try {
      var response = await _dio.post(
        "/api/collections/users/records",
        data: {
          "username": name,
          "email": email,
          "password": password,
          "passwordConfirm": passwordConfirm,
        },
      );
      if (response.statusCode == 200) {
        login(password, email);
      }
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 9);
    }
  }

  @override
  Future<String> login(String password, String identity) async {
    try {
      var response = await _dio.post(
        '/api/collections/users/auth-with-password',
        data: {
          "identity": identity,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        var token = response.data["token"];
        var username = response.data["record"]["username"];
        AuthManager.saveToken(token);
        AuthManager.saveId(username);
        return token;
      }
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 9);
    }
    return "";
  }
}
