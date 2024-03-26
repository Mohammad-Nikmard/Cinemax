abstract class CommentsEvent {}

class CommentFetchEvent extends CommentsEvent {
  String movieID;

  CommentFetchEvent(this.movieID);
}
