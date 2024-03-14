import 'package:cinemax/bloc/search/search_event.dart';
import 'package:cinemax/bloc/search/search_state.dart';
import 'package:cinemax/data/model/actors.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/data/repository/movie_repository.dart';
import 'package:cinemax/data/repository/search_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MovieRepository _movieRemoteRpository;
  final SearchRepository _searchRepository;
  SearchBloc(this._movieRemoteRpository, this._searchRepository)
      : super(SearchInitState()) {
    on<SearchFetchDataEvent>(
      (event, emit) async {
        emit(SearchLoadingState());
        var movies = await _searchRepository.getRecommendedMovies();
        var allMovies = await _movieRemoteRpository.getAllMovies();
        emit(SearchResponseState(movies, allMovies));
      },
    );

    on<SearchAllMoviesEvent>(
      (event, emit) async {
        emit(SearchLoadingState());
        var allMovies = await _movieRemoteRpository.getAllMovies();
        var actors = await _searchRepository.getActors();
        emit(SearchAllMoviesResponse(allMovies, actors));
      },
    );

    on<SearchQueryEvent>(
      (event, emit) async {
        List<Movie> searchResult = [];
        List<Actors> searchActors = [];
        var allMovies = await _movieRemoteRpository.getAllMovies();
        var actors = await _searchRepository.getActors();
        actors.fold(
          (l) {},
          (actorsList) {
            searchActors = actorsList
                .where((element) => element.name
                    .toLowerCase()
                    .contains(event.query.toLowerCase()))
                .toList();
          },
        );
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
        if (searchActors.isEmpty && searchResult.isEmpty) {
          emit(EmptySearchState());
        } else if (searchActors.isNotEmpty && searchResult.isNotEmpty) {
          emit(SearchResultState(searchResult, searchActors));
        }
      },
    );
  }
}
