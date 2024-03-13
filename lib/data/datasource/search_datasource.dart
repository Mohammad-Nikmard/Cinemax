import 'package:cinemax/data/model/actors.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class SearchDatasource {
  Future<List<Actors>> getActors();
  Future<List<Movie>> getRecommendedMovies();
}

class SearchRemoteDatasource extends SearchDatasource {
  final Dio _dio;

  SearchRemoteDatasource(this._dio);

  @override
  Future<List<Actors>> getActors() async {
    try {
      var response = await _dio.get("/api/collections/actors/records");
      return response.data["items"]
          .map<Actors>((jsonMapObject) => Actors.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.message!, ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 11);
    }
  }

  @override
  Future<List<Movie>> getRecommendedMovies() async {
    Map<String, dynamic> qparams = {
      'filter': 'query="recommend"&&category="movie"',
    };
    try {
      var response = await _dio.get("/api/collections/movies/records",
          queryParameters: qparams);
      return response.data["items"]
          .map<Movie>((jsonMapObject) => Movie.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.message!, ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 2);
    }
  }
}
