import 'package:cinemax/data/model/comment.dart';
import 'package:cinemax/data/model/user_reply.dart';

class CommentReply {
  Comment comment;
  List<UserReply> replies;

  CommentReply(this.comment, this.replies);
}
