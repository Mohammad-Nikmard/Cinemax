import 'package:cinemax/data/model/comment.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:cinemax/util/auth_manager.dart';
import 'package:dio/dio.dart';

abstract class CommentsDatasource {
  Future<List<Comment>> getComments(String movieID, int numbers);
  Future<void> postComment(
      String movieID, text, headline, time, double rate, bool spoiler);
}

class CommentRemoteDatasource extends CommentsDatasource {
  final Dio _dio;

  CommentRemoteDatasource(this._dio);
  @override
  Future<List<Comment>> getComments(String movieID, int numbers) async {
    Map<String, dynamic> qparams = {
      'filter': 'movie_id= "$movieID"',
      'expand': 'user_id',
      'perPage': numbers,
    };
    try {
      var response = await _dio.get(
        "/api/collections/movies_comment/records",
        queryParameters: qparams,
      );
      return response.data["items"]
          .map<Comment>((jsonMapObject) => Comment.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 8);
    }
  }

  @override
  Future<void> postComment(
      String movieID, text, headline, time, double rate, bool spoiler) async {
    try {
      await _dio.post(
        "/api/collections/movies_comment/records",
        data: {
          'text': text,
          'headline': headline,
          'time': time,
          'movie_id': movieID,
          'user_id': AuthManager.readRecordID(),
          'rate': rate,
          'spoiler': spoiler,
        },
      );
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 9);
    }
  }
}
