import 'package:dio/dio.dart';

class ApiException implements Exception {
  String message;
  int? errorCode;
  Response? response;

  ApiException(this.message, this.errorCode, {this.response}) {
    if (errorCode != 400) {
      return;
    } else if (message == "Failed to authenticate.") {
      message = "You have entered an invalid username or password";
    }
    if (message == "Failed to create record.") {
      if (response?.data["data"]["username"] != null) {
        if (response?.data["data"]["username"]["message"] ==
            "The username is invalid or already in use.") {
          message = "The username is invalid or already in use.";
        }
      }
    }
  }
}
