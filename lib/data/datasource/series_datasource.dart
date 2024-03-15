import 'package:cinemax/data/model/episode.dart';
import 'package:cinemax/data/model/series_cast.dart';
import 'package:cinemax/data/model/series_seasons.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class SeriesDatasource {
  Future<List<SeriesSeasons>> getSeasons(String seriesId);
  Future<List<SeriesCasts>> getSeriesCasts(String seriesId);
  Future<List<Episode>> getSeriesEpisodes(String season);
  Future<List<Episode>> getFirstSeasonEpisode(String seriesId);
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
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 6);
    }
  }

  @override
  Future<List<SeriesCasts>> getSeriesCasts(String seriesId) async {
    Map<String, dynamic> qparams = {
      'filter': 'series_id="$seriesId"',
    };
    try {
      var response = await _dio.get(
        "/api/collections/series_cast/records",
        queryParameters: qparams,
      );
      return response.data["items"]
          .map<SeriesCasts>(
              (jsonMapObject) => SeriesCasts.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 6);
    }
  }

  @override
  Future<List<Episode>> getSeriesEpisodes(String season) async {
    Map<String, dynamic> qparams = {
      'filter': 'season_id="$season"',
    };
    try {
      var response = await _dio.get("/api/collections/episodes/records",
          queryParameters: qparams);
      return response.data["items"]
          .map<Episode>((jsonMapObject) => Episode.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 11);
    }
  }

  @override
  Future<List<Episode>> getFirstSeasonEpisode(String seriesId) async {
    List<SeriesSeasons> seasonList = await getSeasons(seriesId);
    Map<String, dynamic> qparams = {
      'filter': 'season_id="${seasonList[0].id}"',
    };
    try {
      var response = await _dio.get("/api/collections/episodes/records",
          queryParameters: qparams);
      return response.data["items"]
          .map<Episode>((jsonMapObject) => Episode.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 11);
    }
  }
}
