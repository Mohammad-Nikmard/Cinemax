abstract class CommentsEvent {}

class CommentFetchEvent extends CommentsEvent {
  String movieID;

  CommentFetchEvent(this.movieID);
}

class PostCommentEvent extends CommentsEvent {
  String movieID;
  String text;
  String headline;
  String time;
  double rate;
  bool spoiler;

  PostCommentEvent(this.movieID, this.text, this.headline, this.time, this.rate,
      this.spoiler);
}
