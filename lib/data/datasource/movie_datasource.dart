import 'package:cinemax/data/model/movie_casts.dart';
import 'package:cinemax/data/model/moviegallery.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class MovieDatasource {
  Future<List<Movie>> getAllMovies();
  Future<List<Movie>> getMovies();
  Future<List<Movie>> getSeries();
  Future<List<Moviesgallery>> getPhotos(String movieId);
  Future<List<MovieCasts>> getCasts(String movieId);
}

class MovieRemoteDatasource extends MovieDatasource {
  final Dio _dio;

  MovieRemoteDatasource(this._dio);
  @override
  Future<List<Movie>> getAllMovies() async {
    try {
      var response = await _dio.get("/api/collections/movies/records");
      return response.data["items"]
          .map<Movie>((jsonMapObject) => Movie.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.message!, ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 1);
    }
  }

  @override
  Future<List<Movie>> getMovies() async {
    Map<String, dynamic> qparams = {
      'filter': 'category= "movie"',
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

  @override
  Future<List<Movie>> getSeries() async {
    Map<String, dynamic> qparams = {
      'filter': 'category= "series"',
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
      throw ApiException("$ex", 3);
    }
  }

  @override
  Future<List<Moviesgallery>> getPhotos(String movieId) async {
    Map<String, dynamic> qparams = {
      'filter': 'movie_id="$movieId"',
    };
    try {
      var response = await _dio.get("/api/collections/movies_gallery/records",
          queryParameters: qparams);
      return response.data["items"]
          .map<Moviesgallery>(
              (jsonMapObject) => Moviesgallery.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.message!, ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 5);
    }
  }

  @override
  Future<List<MovieCasts>> getCasts(String movieId) async {
    Map<String, dynamic> qparams = {'filter': 'movie_id="$movieId"'};
    try {
      var response = await _dio.get(
        "/api/collections/movie_casts/records",
        queryParameters: qparams,
      );
      return response.data["items"]
          .map<MovieCasts>(
              (jsonMapObject) => MovieCasts.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.message!, ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 7);
    }
  }
}
