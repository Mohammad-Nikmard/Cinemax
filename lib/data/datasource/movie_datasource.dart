import 'package:cinemax/data/model/movie_casts.dart';
import 'package:cinemax/data/model/moviegallery.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class MovieDatasource {
  Future<List<Movie>> getAllMovies();
  Future<List<Movie>> getLatestMovies();
  Future<List<Movie>> getHottestMovies();
  Future<List<Movie>> getForYouMovies();
  Future<List<Movie>> getForYouSeries();
  Future<List<Movie>> getHottestSeries();
  Future<List<Moviesgallery>> getPhotos(String movieId);
  Future<List<MovieCasts>> getCasts(String movieId);
  Future<List<Movie>> getShortSeries();
  Future<List<Movie>> getRelateds(String movieID);
}

class MovieRemoteDatasource extends MovieDatasource {
  final Dio _dio;

  MovieRemoteDatasource(this._dio);
  @override
  Future<List<Movie>> getAllMovies() async {
    Map<String, dynamic> qparams = {
      'perPage': 1000,
    };
    try {
      var response = await _dio.get("/api/collections/movies/records",
          queryParameters: qparams);
      return response.data["items"]
          .map<Movie>((jsonMapObject) => Movie.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 10);
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
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 11);
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
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 12);
    }
  }

  @override
  Future<List<Movie>> getForYouMovies() async {
    Map<String, dynamic> qparams = {
      'filter': 'query="for you"&&category="movie"',
    };
    try {
      var response = await _dio.get("/api/collections/movies/records",
          queryParameters: qparams);
      return response.data["items"]
          .map<Movie>((jsonMapObject) => Movie.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 13);
    }
  }

  @override
  Future<List<Movie>> getHottestMovies() async {
    Map<String, dynamic> qparams = {
      'filter': 'query="hottest"&&category="movie"',
    };
    try {
      var response = await _dio.get("/api/collections/movies/records",
          queryParameters: qparams);
      return response.data["items"]
          .map<Movie>((jsonMapObject) => Movie.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 14);
    }
  }

  @override
  Future<List<Movie>> getLatestMovies() async {
    Map<String, dynamic> qparams = {
      'filter': 'query="latest"&&category="movie"',
    };
    try {
      var response = await _dio.get("/api/collections/movies/records",
          queryParameters: qparams);
      return response.data["items"]
          .map<Movie>((jsonMapObject) => Movie.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 15);
    }
  }

  @override
  Future<List<Movie>> getForYouSeries() async {
    Map<String, dynamic> qparams = {
      'filter': 'category="series"&&query="for you"',
    };
    try {
      var response = await _dio.get("/api/collections/movies/records",
          queryParameters: qparams);
      return response.data["items"]
          .map<Movie>((jsonMapObject) => Movie.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 16);
    }
  }

  @override
  Future<List<Movie>> getHottestSeries() async {
    Map<String, dynamic> qparams = {
      'filter': 'category="series"&&query="hottest"',
    };
    try {
      var response = await _dio.get("/api/collections/movies/records",
          queryParameters: qparams);
      return response.data["items"]
          .map<Movie>((jsonMapObject) => Movie.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 17);
    }
  }

  @override
  Future<List<Movie>> getShortSeries() async {
    Map<String, dynamic> qparams = {
      'filter': 'category="series"&&query="shortS"',
    };
    try {
      var response = await _dio.get("/api/collections/movies/records",
          queryParameters: qparams);
      return response.data["items"]
          .map<Movie>((jsonMapObject) => Movie.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 18);
    }
  }

  @override
  Future<List<Movie>> getRelateds(String movieID) async {
    Map<String, dynamic> qparams = {
      'filter': 'name="$movieID"',
      'expand': 'related_movie',
    };
    try {
      var response = await _dio.get("/api/collections/movies/records",
          queryParameters: qparams);
      return response.data["items"][0]["expand"]["related_movie"]
          .map<Movie>((jsonMapObject) => Movie.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 100);
    }
  }
}
