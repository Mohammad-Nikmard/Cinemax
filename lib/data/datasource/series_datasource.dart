import 'package:cinemax/data/model/series_seasons.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class SeriesDatasource {
  Future<List<SeriesSeasons>> getSeasons(String seriesId);
}

class SeriesRemoteDatasource extends SeriesDatasource {
  final Dio _dio;

  SeriesRemoteDatasource(this._dio);
  @override
  Future<List<SeriesSeasons>> getSeasons(String seriesId) async {
    Map<String, dynamic> qparams = {
      'filter': 'series_id="$seriesId"',
    };
    try {
      var response = await _dio.get(
        "/api/collections/series_seasons/records",
        queryParameters: qparams,
      );
      return response.data["items"]
          .map<SeriesSeasons>(
              (jsonMapObject) => SeriesSeasons.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.message!, ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 6);
    }
  }
}
