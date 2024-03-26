abstract class CommentsEvent {}

class CommentFetchEvent extends CommentsEvent {
  String movieID;

  CommentFetchEvent(this.movieID);
}

class PostCommentEvent extends CommentsEvent {
  String movieID;
  String text;
  String headline;
  double rate;
  bool spoiler;

  PostCommentEvent(
      this.movieID, this.text, this.headline, this.rate, this.spoiler);
}
