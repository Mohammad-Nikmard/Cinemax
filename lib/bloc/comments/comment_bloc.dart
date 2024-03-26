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
  }
}
