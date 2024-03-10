import 'package:cinemax/data/datasource/upcomings_datasource.dart';
import 'package:cinemax/data/model/upcomings.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class UpcomingsRepository {
  Future<Either<String, List<Upcomings>>> getUpcomingsList();
}

class UpcomingsRemoteRepository extends UpcomingsRepository {
  final UpcomingsDatasource _datasource;

  UpcomingsRemoteRepository(this._datasource);
  @override
  Future<Either<String, List<Upcomings>>> getUpcomingsList() async {
    try {
      var response = await _datasource.getUpcomings();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }
}
