import 'dart:io';
// import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:cinemax/util/auth_manager.dart';
import 'package:dio/dio.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:mime_type/mime_type.dart';
// import 'package:pocketbase/pocketbase.dart';

abstract class AuthenticationDatasource {
  Future<void> register(
      String email, String name, String password, String passwordConfirm);

  Future<String> login(String password, String identity);
  Future<String> updateData(File image, String id);
}

class AuthenticationRemoteDatasource extends AuthenticationDatasource {
  final Dio _dio;
  final user = AuthManager.getUser();

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
        var id = response.data["record"]["id"];
        var email = identity;
        AuthManager.saveToken(token);
        AuthManager.saveId(username);
        AuthManager.saveEmail(email);
        AuthManager.saveRecordID(id);
        return token;
      }
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode,
          response: ex.response);
    } catch (ex) {
      throw ApiException("$ex", 9);
    }
    return "";
  }

  @override
  Future<String> updateData(File image, String id) async {
    // String fileName = user.imagePath.split('/').last;
    // String mimeType = mime(fileName) ?? '';
    // String mimee = mimeType.split('/')[0];
    // String type = mimeType.split('/')[1];

    // var imageData = FormData.fromMap({
    //   "image": await MultipartFile.fromFile(
    //     image.path,
    //     filename: fileName,
    //     contentType: MediaType(mimee, type),
    //   ),
    // });
    try {
      // var response = await _dio.patch(
      //   "/api/collections/users/records/:$id",
      //   data: {
      //     "profile_pic": image,
      //   },
      // );
      // final pb = PocketBase(StringConstants.baseImage);
      // final body = <String, dynamic>{
      //   "profile_pic": imageData,
      // };
      // await pb.collection('users').update(id, body: body);
      // if (record. == 200) {
      //   return "Success";
      // }
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 12);
    }
    return "";
  }
}
