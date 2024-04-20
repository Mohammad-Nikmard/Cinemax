import 'package:cinemax/data/datasource/reply_datasource.dart';
import 'package:cinemax/data/model/user_reply.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ReplyRepository {
  Future<Either<String, List<UserReply>>> getReplies(String commentId);
  Future<Either<String, String>> postReply(
      String commentID, String userId, String text, String date);
}

class ReplyRemoteRepository extends ReplyRepository {
  final ReplyDatasource _datasource;

  ReplyRemoteRepository(this._datasource);

  @override
  Future<Either<String, List<UserReply>>> getReplies(String commentId) async {
    try {
      var response = await _datasource.getReplies(commentId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }

  @override
  Future<Either<String, String>> postReply(
      String commentID, String userId, String text, String date) async {
    try {
      await _datasource.postReply(commentID, userId, text, date);
      return right("Successfuly posted reply");
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }
}
