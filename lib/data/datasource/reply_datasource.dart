import 'package:cinemax/data/model/user_reply.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class ReplyDatasource {
  Future<List<UserReply>> getReplies(String commentId);
  Future<void> postReply(
      String commentID, String userId, String text, String date);

  Future<void> replyONlike(String replyId, String userId);
  Future<void> replyOFFlike(String replyId, String userId);
  Future<void> replyONdislike(String replyId, String userId);
  Future<void> replyOFFdislike(String replyId, String userId);

  Future<List<UserReply>> getUserReplies(String userId);
}

class ReplyRemoteDatasource extends ReplyDatasource {
  final Dio _dio;

  ReplyRemoteDatasource(this._dio);
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

  @override
  Future<void> postReply(
      String commentID, String userId, String text, String date) async {
    try {
      await _dio.post("/api/collections/replies/records", data: {
        "text": text,
        'date': date,
        'user_id': userId,
        'comment_id': commentID,
      });
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 100);
    }
  }

  @override
  Future<void> replyOFFlike(String replyId, String userId) async {
    try {
      await _dio.patch("/api/collections/replies/records/$replyId",
          data: {'like-': userId});
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 100);
    }
  }

  @override
  Future<void> replyONdislike(String replyId, String userId) async {
    try {
      await _dio.patch("/api/collections/replies/records/$replyId",
          data: {'dislike+': userId});
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 100);
    }
  }

  @override
  Future<void> replyONlike(String replyId, String userId) async {
    try {
      await _dio.patch("/api/collections/replies/records/$replyId",
          data: {'like+': userId});
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 100);
    }
  }

  @override
  Future<void> replyOFFdislike(String replyId, String userId) async {
    try {
      await _dio.patch("/api/collections/replies/records/$replyId",
          data: {'dislike-': userId});
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 100);
    }
  }

  @override
  Future<List<UserReply>> getUserReplies(String userId) async {
    Map<String, dynamic> qparams = {
      'filter': 'user_id= "$userId"',
      'expand': 'user_id',
    };
    try {
      var response = await _dio.get("/api/collections/replies/records",
          queryParameters: qparams);
      return response.data["items"]
          .map<UserReply>((jsonMapObject) => UserReply.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 100);
    }
  }
}
