import 'package:cinemax/data/datasource/comments_datasource.dart';
import 'package:cinemax/data/model/comment.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class CommentsRepository {
  Future<Either<String, List<Comment>>> getComments(String movieID);
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
}
