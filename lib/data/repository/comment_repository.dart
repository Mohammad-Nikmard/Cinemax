import 'package:cinemax/data/datasource/comments_datasource.dart';
import 'package:cinemax/data/model/comment.dart';
import 'package:cinemax/data/model/comment_reply.dart';
import 'package:cinemax/data/model/user_comment.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class CommentsRepository {
  Future<Either<String, List<Comment>>> getComments(String movieID,
      {int numbers});
  Future<Either<String, String>> postComment(
      String movieID, text, headline, time, double rate, bool spoiler);
  Future<Either<String, List<UserComment>>> getUserComments(
      String userRecordID);
  Future<Either<String, String>> deleteComment(String commentID);
  Future<Either<String, String>> updateComment(String commentID, String text,
      String headline, double rate, String time, bool spoiler);

  Future<List<CommentReply>> getCommentReplies(String movieID,
      {int numbers = 30});

  Future<void> commentOnlike(String commentId, String userId);
  Future<void> commentOFFlike(String commentId, String userId);
  Future<void> commentONdislike(String commentId, String userId);
  Future<void> commentOFFdislike(String commentId, String userId);
}

class CommentsRemoteRepository extends CommentsRepository {
  final CommentsDatasource _datasource;

  CommentsRemoteRepository(this._datasource);
  @override
  Future<Either<String, List<Comment>>> getComments(String movieID,
      {int numbers = 30}) async {
    try {
      var response = await _datasource.getComments(movieID, numbers);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, String>> postComment(
      String movieID, text, headline, time, double rate, bool spoiler) async {
    try {
      await _datasource.postComment(
          movieID, text, headline, time, rate, spoiler);
      return right("commend is successfully added");
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, List<UserComment>>> getUserComments(
      String userRecordID) async {
    try {
      var response = await _datasource.getUserComments(userRecordID);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, String>> deleteComment(String commentID) async {
    try {
      await _datasource.deleteComment(commentID);
      return right("Success");
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, String>> updateComment(String commentID, String text,
      String headline, double rate, String time, bool spoiler) async {
    try {
      var response = await _datasource.updateComment(
          commentID, text, headline, rate, time, spoiler);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<List<CommentReply>> getCommentReplies(String movieID,
      {int numbers = 30}) async {
    var response = await _datasource.getCommentReplies(movieID, numbers);

    return response;
  }

  @override
  Future<void> commentOFFdislike(String commentId, String userId) async {
    await _datasource.commentOFFdislike(commentId, userId);
  }

  @override
  Future<void> commentOFFlike(String commentId, String userId) async {
    await _datasource.commnetOFFlike(commentId, userId);
  }

  @override
  Future<void> commentONdislike(String commentId, String userId) async {
    await _datasource.commentONdislike(commentId, userId);
  }

  @override
  Future<void> commentOnlike(String commentId, String userId) async {
    await _datasource.commentOnlike(commentId, userId);
  }
}
