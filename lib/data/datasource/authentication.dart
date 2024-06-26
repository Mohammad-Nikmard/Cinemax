import 'package:cinemax/data/model/user.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:cinemax/util/auth_manager.dart';
import 'package:dio/dio.dart';

abstract class AuthenticationDatasource {
  Future<void> register(
      String email, String name, String password, String passwordConfirm);
  Future<String> login(String password, String identity);
  Future<UserApp> getCurrentUser(String id);
  Future<dynamic> sendImageProfile(String userid, image);
  Future<void> sendFeedback(double rate, String text);
  Future<dynamic> sendUserName(String userID, name);
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
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode,
          response: ex.response);
    } catch (ex) {
      throw ApiException("$ex", 0);
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
        var id = response.data["record"]["id"];
        var email = identity;
        AuthManager.saveToken(token);
        AuthManager.saveEmail(email);
        AuthManager.saveRecordID(id);
        return token;
      }
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode,
          response: ex.response);
    } catch (ex) {
      throw ApiException("$ex", 1);
    }
    return "";
  }

  @override
  Future<UserApp> getCurrentUser(String id) async {
    Map<String, dynamic> qparams = {
      'filter': 'id="$id"',
    };
    try {
      var response = await _dio.get(
        "/api/collections/users/records",
        queryParameters: qparams,
      );
      return UserApp.withJson(response.data["items"][0]);
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 2);
    }
  }

  @override
  Future<dynamic> sendImageProfile(String userid, image) async {
    FormData formData = FormData.fromMap({
      "profile_pic":
          image == null ? null : await MultipartFile.fromFile(image.path),
    });

    try {
      await _dio.patch(
        "/api/collections/users/records/$userid",
        data: formData,
      );
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 3);
    }
  }

  @override
  Future<void> sendFeedback(double rate, String text) async {
    try {
      await _dio.post(
        "/api/collections/feedback/records",
        data: {
          "rate": rate,
          "text": text,
        },
      );
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 4);
    }
  }

  @override
  Future sendUserName(String userID, name) async {
    FormData formData = FormData.fromMap({
      'username': name,
    });
    try {
      await _dio.patch(
        "/api/collections/users/records/$userID",
        data: formData,
      );
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 5);
    }
  }
}
