import 'package:cinemax/bloc/search/search_event.dart';
import 'package:cinemax/bloc/search/search_state.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/data/repository/movie_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearhcBloc extends Bloc<SearchEvent, SearchState> {
  final MovieRepository _movieRemoteRpository;
  SearhcBloc(this._movieRemoteRpository) : super(SearchInitState()) {
    on<SearchFetchDataEvent>(
      (event, emit) async {
        emit(SearchLoadingState());
        var movies = await _movieRemoteRpository.getMovies();
        emit(SearchResponseState(movies));
      },
    );

    on<SearchAllMoviesEvent>(
      (event, emit) async {
        emit(SearchLoadingState());
        var allMovies = await _movieRemoteRpository.getAllMovies();
        emit(SearchAllMoviesResponse(allMovies));
      },
    );

    on<SearchQueryEvent>(
      (event, emit) async {
        List<Movie> searchResult = [];
        var allMovies = await _movieRemoteRpository.getAllMovies();
        allMovies.fold(
          (l) {},
          (movieList) {
            searchResult = movieList
                .where(
                  (element) => element.name.toLowerCase().contains(
                        event.query.toLowerCase(),
                      ),
                )
                .toList();
          },
        );
        emit(SearchResultState(searchResult));
      },
    );
  }
}
