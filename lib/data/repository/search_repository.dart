import 'package:cinemax/data/datasource/search_datasource.dart';
import 'package:cinemax/data/model/actors.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRepository {
  Future<Either<String, List<Actors>>> getActors();
}

class SearchRemoteRepository extends SearchRepository {
  final SearchDatasource _datasource;

  SearchRemoteRepository(this._datasource);

  @override
  Future<Either<String, List<Actors>>> getActors() async {
    try {
      var response = await _datasource.getActors();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }
}
