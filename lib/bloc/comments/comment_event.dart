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

class ShowMoreCommentsEvent extends CommentsEvent {
  int page;
  String movieID;

  ShowMoreCommentsEvent(this.page, this.movieID);
}

class FetchUserComments extends CommentsEvent {
  String userID;

  FetchUserComments(this.userID);
}

class DeleteCommentEvent extends CommentsEvent {
  String commentID;
  String userID;

  DeleteCommentEvent(this.commentID, this.userID);
}

class EditCommentEvent extends CommentsEvent {
  String commentID;
  String text;
  String headline;
  String time;
  double rate;
  bool spoiler;

  EditCommentEvent(this.commentID, this.text, this.headline, this.time,
      this.rate, this.spoiler);
}

class FetchRepliesEvent extends CommentsEvent {
  String commentID;

  FetchRepliesEvent(this.commentID);
}

class PostReplyEvent extends CommentsEvent {
  String text;
  String date;
  String userId;
  String commentId;

  PostReplyEvent(
      this.text, this.date, this.userId, this.commentId);
}
