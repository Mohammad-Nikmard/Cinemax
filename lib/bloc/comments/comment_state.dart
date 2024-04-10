import 'package:cinemax/data/model/comment.dart';
import 'package:cinemax/data/model/user_comment.dart';
import 'package:dartz/dartz.dart';

abstract class CommentsState {}

class CommentsInitState extends CommentsState {}

class CommensLoadingState extends CommentsState {}

class CommentsResponseState extends CommentsState {
  Either<String, List<Comment>> getComments;

  CommentsResponseState(this.getComments);
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
