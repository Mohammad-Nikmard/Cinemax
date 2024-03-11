import 'package:cinemax/data/datasource/upcomings_datasource.dart';
import 'package:cinemax/data/model/upcoming_cast.dart';
import 'package:cinemax/data/model/upcoming_gallery.dart';
import 'package:cinemax/data/model/upcomings.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class UpcomingsRepository {
  Future<Either<String, List<Upcomings>>> getUpcomingsList();
  Future<Either<String, List<UpcomingGallery>>> getPhotos(String upId);
  Future<Either<String, List<UpcomingsCasts>>> getCasts(String upId);
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

  @override
  Future<Either<String, List<UpcomingGallery>>> getPhotos(String upId) async {
    try {
      var response = await _datasource.getPhotos(upId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, List<UpcomingsCasts>>> getCasts(String upId) async {
    try {
      var response = await _datasource.getCasts(upId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }
}
