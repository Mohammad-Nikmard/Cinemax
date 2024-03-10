import 'package:cinemax/data/datasource/movie_datasource.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<String, List<Movie>>> getAllMovies();
  Future<Either<String, List<Movie>>> getMovies();
  Future<Either<String, List<Movie>>> getSeries();
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
  Future<Either<String, List<Movie>>> getMovies() async {
    try {
      var response = await _datasource.getMovies();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, List<Movie>>> getSeries() async {
    try {
      var response = await _datasource.getSeries();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }
}
