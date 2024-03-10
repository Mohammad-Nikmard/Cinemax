import 'package:dio/dio.dart';

class DioHandler {
  static Dio dioWithoutHeader() {
    return Dio(
      BaseOptions(
        baseUrl: "https://pocketbase-t303vjb-1.liara.run",
      ),
    );
  }
}
