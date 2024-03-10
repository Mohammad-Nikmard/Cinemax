class ApiException implements Exception {
  String message;
  int? errorCode;

  ApiException(this.message, this.errorCode);
}


// 0 : banner errors