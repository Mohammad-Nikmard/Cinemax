import 'package:cinemax/data/model/video.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class VideoDatasource {
  Future<VideoModel> getVideo(String movieID);
  Future<VideoModel> getTrailer(String movieID);
}

class VideoRemoteDatasource extends VideoDatasource {
  final Dio _dio;

  VideoRemoteDatasource(this._dio);
  @override
  Future<VideoModel> getVideo(String movieID) async {
    Map<String, dynamic> qparams = {'filter': 'movie_id= "$movieID"'};
    try {
      var response = await _dio.get("/api/collections/movie_trailers/records",
          queryParameters: qparams);
      return VideoModel.withJson(response.data["items"][0]);
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 17);
    }
  }

  @override
  Future<VideoModel> getTrailer(String movieID) async {
    Map<String, dynamic> qparams = {
      'filter': 'movie_id= "$movieID"',
    };
    try {
      var response = await _dio.get("/api/collections/upcoming_trailer/records",
          queryParameters: qparams);
      return VideoModel.withJson(response.data["items"][0]);
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 20);
    }
  }
}
