import 'package:cinemax/data/model/upcomings.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class UpcomingsDatasource {
  Future<List<Upcomings>> getUpcomings();
}

class UpcomingsRemoteDatasource extends UpcomingsDatasource {
  final Dio _dio;

  UpcomingsRemoteDatasource(this._dio);
  @override
  Future<List<Upcomings>> getUpcomings() async {
    try {
      var response = await _dio.get("/api/collections/upcomings/records");
      return response.data["items"]
          .map<Upcomings>((jsonMapObject) => Upcomings.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.message!, ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 4);
    }
  }
}
