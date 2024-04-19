import 'package:cinemax/data/model/comment.dart';
import 'package:cinemax/data/model/user_comment.dart';
import 'package:cinemax/data/model/user_reply.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:cinemax/util/auth_manager.dart';
import 'package:dio/dio.dart';

abstract class CommentsDatasource {
  Future<List<Comment>> getComments(String movieID, int numbers);
  Future<void> postComment(
      String movieID, text, headline, time, double rate, bool spoiler);
  Future<List<UserComment>> getUserComments(String userRecord);
  Future<void> deleteComment(String commentID);
  Future<String> updateComment(String commentID, String text, String headline,
      double rate, String time, bool spoiler);
  Future<List<UserReply>> getReplies(String commentId);
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

  @override
  Future<List<UserComment>> getUserComments(String userRecord) async {
    Map<String, dynamic> qparams = {
      'filter': 'user_id="$userRecord"',
      'expand': 'user_id,movie_id',
    };
    try {
      var response = await _dio.get(
        "/api/collections/movies_comment/records",
        queryParameters: qparams,
      );
      return response.data["items"]
          .map<UserComment>(
              (jsonMapObject) => UserComment.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 100);
    }
  }

  @override
  Future<void> deleteComment(String commentID) async {
    try {
      await _dio.delete("/api/collections/movies_comment/records/$commentID");
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 100);
    }
  }

  @override
  Future<String> updateComment(String commentID, String text, String headline,
      double rate, String time, bool spoiler) async {
    FormData data = FormData.fromMap({
      'headline': headline,
      'text': text,
      'rate': rate,
      'time': time,
      'spoiler': spoiler,
    });
    try {
      var response = await _dio.patch(
        "/api/collections/movies_comment/records/$commentID",
        data: data,
      );
      if (response.statusCode == 200) {
        return "Success";
      }
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 100);
    }
    return "";
  }

  @override
  Future<List<UserReply>> getReplies(String commentId) async {
    Map<String, dynamic> qparams = {
      'filter': 'comment_id= "$commentId"',
      'expand': 'user_id',
    };
    try {
      var response = await _dio.get("/api/collections/replies/records",
          queryParameters: qparams);
      return response.data['items']
          .map<UserReply>((jsonMapObject) => UserReply.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 100);
    }
  }
}
