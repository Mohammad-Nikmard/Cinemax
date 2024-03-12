import 'package:cinemax/data/model/movie.dart';
import 'package:dartz/dartz.dart';

abstract class SearchState {}

class SearchInitState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchResponseState extends SearchState {
  Either<String, List<Movie>> getMovies;

  SearchResponseState(this.getMovies);
}

class SearchAllMoviesResponse extends SearchState {
  Either<String, List<Movie>> getAllMovies;

  SearchAllMoviesResponse(this.getAllMovies);
}

class SearchResultState extends SearchState {
  List<Movie> moviesearch;

  SearchResultState(this.moviesearch);
}
