import 'package:cinemax/data/datasource/comments_datasource.dart';
import 'package:cinemax/data/model/comment.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class CommentsRepository {
  Future<Either<String, List<Comment>>> getComments(String movieID);
  Future<Either<String, String>> postComment(
      String movieID, text, headline, double rate, bool spoiler);
}

class CommentsRemoteRepository extends CommentsRepository {
  final CommentsDatasource _datasource;

  CommentsRemoteRepository(this._datasource);
  @override
  Future<Either<String, List<Comment>>> getComments(String movieID) async {
    try {
      var response = await _datasource.getComments(movieID);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, String>> postComment(
      String movieID, text, headline, double rate, bool spoiler) async {
    try {
      await _datasource.postComment(movieID, text, headline, rate, spoiler);
      return right("commend is successfully added");
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }
}
