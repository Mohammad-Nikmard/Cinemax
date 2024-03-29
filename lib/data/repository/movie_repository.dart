import 'package:cinemax/data/datasource/movie_datasource.dart';
import 'package:cinemax/data/model/movie_casts.dart';
import 'package:cinemax/data/model/moviegallery.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<String, List<Movie>>> getAllMovies();
  Future<Either<String, List<Movie>>> getLatestMovies();
  Future<Either<String, List<Movie>>> getHottestMovies();
  Future<Either<String, List<Movie>>> getForYouMovies();
  Future<Either<String, List<Movie>>> getForYouSeries();
  Future<Either<String, List<Movie>>> getHottestSeries();
  Future<Either<String, List<Moviesgallery>>> getPhotos(String movieId);
  Future<Either<String, List<MovieCasts>>> getCastList(String movieId);
  Future<Either<String, List<Movie>>> getShortSeries();
}

class MovieRemoteRpository extends MovieRepository {
  final MovieDatasource _datasource;

  MovieRemoteRpository(this._datasource);
  @override
  Future<Either<String, List<Movie>>> getAllMovies() async {
    try {
      var response = await _datasource.getAllMovies();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, List<Moviesgallery>>> getPhotos(String movieId) async {
    try {
      var response = await _datasource.getPhotos(movieId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, List<MovieCasts>>> getCastList(String movieId) async {
    try {
      var response = await _datasource.getCasts(movieId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, List<Movie>>> getForYouMovies() async {
    try {
      var response = await _datasource.getForYouMovies();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, List<Movie>>> getHottestMovies() async {
    try {
      var response = await _datasource.getHottestMovies();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, List<Movie>>> getLatestMovies() async {
    try {
      var response = await _datasource.getLatestMovies();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, List<Movie>>> getForYouSeries() async {
    try {
      var response = await _datasource.getForYouSeries();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, List<Movie>>> getHottestSeries() async {
    try {
      var response = await _datasource.getHottestSeries();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, List<Movie>>> getShortSeries() async {
    try {
      var response = await _datasource.getShortSeries();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }
}
