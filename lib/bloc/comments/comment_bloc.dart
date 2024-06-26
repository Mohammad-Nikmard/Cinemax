import 'package:cinemax/bloc/comments/comment_event.dart';
import 'package:cinemax/bloc/comments/comment_state.dart';
import 'package:cinemax/data/repository/comment_repository.dart';
import 'package:cinemax/data/repository/reply_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final CommentsRepository _commentsRemoteRepository;
  final ReplyRepository _replyRepository;
  CommentsBloc(this._commentsRemoteRepository, this._replyRepository)
      : super(CommentsInitState()) {
    on<CommentFetchEvent>(
      (event, emit) async {
        emit(CommensLoadingState());
        var comments =
            await _commentsRemoteRepository.getComments(event.movieID);
        var replies =
            await _commentsRemoteRepository.getCommentReplies(event.movieID);
        emit(CommentsResponseState(comments, replies));
      },
    );

    on<PostCommentEvent>(
      (event, emit) async {
        emit(CommensLoadingState());
        var response = await _commentsRemoteRepository.postComment(
            event.movieID,
            event.text,
            event.headline,
            event.time,
            event.rate,
            event.spoiler);
        emit(PostCommentResponse(response));
      },
    );
    on<ShowMoreCommentsEvent>(
      (event, emit) async {
        var getComments = await _commentsRemoteRepository
            .getComments(event.movieID, numbers: event.page);
        var replies =
            await _commentsRemoteRepository.getCommentReplies(event.movieID);
        emit(CommentsResponseState(getComments, replies));
      },
    );
    on<FetchUserComments>(
      (event, emit) async {
        emit(CommensLoadingState());
        var userComments =
            await _commentsRemoteRepository.getUserComments(event.userID);
        emit(UserCommentResponseState(userComments));
      },
    );
    on<DeleteCommentEvent>(
      (event, emit) async {
        emit(CommensLoadingState());
        await _commentsRemoteRepository.deleteComment(event.commentID);
        var userComments =
            await _commentsRemoteRepository.getUserComments(event.userID);
        emit(UserCommentResponseState(userComments));
      },
    );
    on<EditCommentEvent>(
      (event, emit) async {
        emit(CommensLoadingState());
        var response = await _commentsRemoteRepository.updateComment(
            event.commentID,
            event.text,
            event.headline,
            event.rate,
            event.time,
            event.spoiler);
        emit(CommentUpdateResponseState(response));
      },
    );
    on<FetchRepliesEvent>(
      (event, emit) async {
        emit(CommensLoadingState());
        var replies = await _replyRepository.getReplies(event.commentID);
        emit(ReplyresponseState(replies));
      },
    );
    on<PostReplyEvent>(
      (event, emit) async {
        emit(CommensLoadingState());
        await _replyRepository.postReply(
            event.commentId, event.userId, event.text, event.date);
        var replies = await _replyRepository.getReplies(event.commentId);
        emit(ReplyresponseState(replies));
      },
    );

    on<LikeEvent>(
      (event, emit) async {
        if (event.condition == true) {
          await _commentsRemoteRepository.commentOnlike(
              event.commentId, event.userId);
        } else if (event.condition == false) {
          await _commentsRemoteRepository.commentOFFlike(
              event.commentId, event.userId);
        }
      },
    );
    on<DislikeEvent>(
      (event, emit) async {
        if (event.condition == true) {
          await _commentsRemoteRepository.commentONdislike(
              event.commentId, event.userId);
        } else if (event.condition == false) {
          await _commentsRemoteRepository.commentOFFdislike(
              event.commentId, event.userId);
        }
      },
    );
    on<ReplyLikeEvent>(
      (event, emit) async {
        if (event.condition == true) {
          await _replyRepository.replyONlike(event.replyId, event.userId);
        } else if (event.condition == false) {
          await _replyRepository.replyOFFlike(event.replyId, event.userId);
        }
      },
    );
    on<ReplyDislikeEvent>(
      (event, emit) async {
        if (event.condition == true) {
          await _replyRepository.replyONdislike(event.replyId, event.userId);
        } else if (event.condition == false) {
          await _replyRepository.replyOFFdislike(event.replyId, event.userId);
        }
      },
    );
    on<YourRepliesFetchEvent>(
      (event, emit) async {
        emit(CommensLoadingState());
        var replies = await _replyRepository.getUserReplies(event.userID);
        emit(ReplyresponseState(replies));
      },
    );
    on<DeleteReplyEvent>(
      (event, emit) async {
        emit(CommensLoadingState());
        await _replyRepository.deleteReply(event.replyId);
        var replies = await _replyRepository.getUserReplies(event.userId);
        emit(ReplyresponseState(replies));
      },
    );
    on<ReportCommentEvent>(
      (event, emit) async {
        emit(CommensLoadingState());
        if (event.commentId != null) {
          await _commentsRemoteRepository.reportComment(event.text,
              commentId: event.commentId!);
        } else if (event.replyId != null) {
          await _commentsRemoteRepository.reportComment(event.text,
              replyId: event.replyId!);
        }
        emit(ReportResponseState());
      },
    );
  }
}
