import 'package:cinemax/data/datasource/comments_datasource.dart';
import 'package:cinemax/data/model/comment.dart';
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
}
