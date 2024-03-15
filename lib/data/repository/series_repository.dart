import 'package:cinemax/data/datasource/series_datasource.dart';
import 'package:cinemax/data/model/episode.dart';
import 'package:cinemax/data/model/series_cast.dart';
import 'package:cinemax/data/model/series_seasons.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class SeriesRepository {
  Future<Either<String, List<SeriesSeasons>>> getSeasons(String seriesId);
  Future<Either<String, List<SeriesCasts>>> getSeriesCast(String seriesId);
  Future<Either<String, List<Episode>>> getEpisodes(String season);
  Future<Either<String, List<Episode>>> getFirstSeasonEpisode(String seriesID);
}

class SeriesRemoteRepository extends SeriesRepository {
  final SeriesDatasource _datasource;

  SeriesRemoteRepository(this._datasource);

  @override
  Future<Either<String, List<SeriesSeasons>>> getSeasons(
      String seriesId) async {
    try {
      var response = await _datasource.getSeasons(seriesId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, List<SeriesCasts>>> getSeriesCast(
      String seriesId) async {
    try {
      var response = await _datasource.getSeriesCasts(seriesId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, List<Episode>>> getEpisodes(String season) async {
    try {
      var response = await _datasource.getSeriesEpisodes(season);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, List<Episode>>> getFirstSeasonEpisode(
      String seriesID) async {
    try {
      var response = await _datasource.getFirstSeasonEpisode(seriesID);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }
}
