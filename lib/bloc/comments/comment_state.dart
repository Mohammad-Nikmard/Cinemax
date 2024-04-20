import 'package:cinemax/data/model/comment.dart';
import 'package:cinemax/data/model/comment_reply.dart';
import 'package:cinemax/data/model/user_comment.dart';
import 'package:cinemax/data/model/user_reply.dart';
import 'package:dartz/dartz.dart';

abstract class CommentsState {}

class CommentsInitState extends CommentsState {}

class CommensLoadingState extends CommentsState {}

class CommentsResponseState extends CommentsState {
  Either<String, List<Comment>> getComments;
  List<CommentReply> getReplies;

  CommentsResponseState(this.getComments, this.getReplies);
}

class PostCommentResponse extends CommentsState {
  Either<String, String> commentResponse;

  PostCommentResponse(this.commentResponse);
}

class UserCommentResponseState extends CommentsState {
  Either<String, List<UserComment>> getComments;

  UserCommentResponseState(this.getComments);
}

class CommentUpdateResponseState extends CommentsState {
  Either<String, String> response;

  CommentUpdateResponseState(this.response);
}

class ReplyresponseState extends CommentsState {
  Either<String, List<UserReply>> getreplies;

  ReplyresponseState(this.getreplies);
}
