import 'package:cinemax/bloc/movies/movies_event.dart';
import 'package:cinemax/bloc/movies/movies_state.dart';
import 'package:cinemax/data/repository/movie_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieBloc extends Bloc<MoviesEvent, MoviesState> {
  final MovieRepository _movieRepository;

  MovieBloc(this._movieRepository) : super(MoviesInitState()) {
    on<MoviesDataRequestEvent>(
      (event, emit) async {
        emit(MoviesLoadingState());
        var photoList = await _movieRepository.getPhotos(event.movieId);
        emit(MoviesresponseState(photoList));
      },
    );
  }
}
