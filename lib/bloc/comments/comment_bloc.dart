import 'package:cinemax/bloc/comments/comment_event.dart';
import 'package:cinemax/bloc/comments/comment_state.dart';
import 'package:cinemax/data/repository/comment_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final CommentsRepository _commentsRemoteRepository;
  CommentsBloc(this._commentsRemoteRepository) : super(CommentsInitState()) {
    on<CommentFetchEvent>(
      (event, emit) async {
        emit(CommensLoadingState());
        var comments =
            await _commentsRemoteRepository.getComments(event.movieID);
        emit(CommentsResponseState(comments));
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
        emit(CommentsResponseState(getComments));
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
  }
}
