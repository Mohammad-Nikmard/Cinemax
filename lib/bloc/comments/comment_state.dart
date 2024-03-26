import 'package:cinemax/data/model/comment.dart';
import 'package:dartz/dartz.dart';

abstract class CommentsState {}

class CommentsInitState extends CommentsState {}

class CommensLoadingState extends CommentsState {}

class CommentsResponseState extends CommentsState {
  Either<String, List<Comment>> getComments;

  CommentsResponseState(this.getComments);
}
