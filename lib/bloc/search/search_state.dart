import 'package:cinemax/data/model/actors.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:dartz/dartz.dart';

abstract class SearchState {}

class SearchInitState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchResponseState extends SearchState {
  Either<String, List<Movie>> getMovies;
  Either<String, List<Movie>> getAllMovies;

  SearchResponseState(this.getMovies, this.getAllMovies);
}

class SearchResultState extends SearchState {
  List<Movie> moviesearch;
  List<Actors> getActors;

  SearchResultState(this.moviesearch, this.getActors);
}

class EmptySearchState extends SearchState {}
