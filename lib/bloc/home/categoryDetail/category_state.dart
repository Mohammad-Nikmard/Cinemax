import 'package:cinemax/data/model/movie.dart';

abstract class CategoryState {}

class CategoryInitState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryResponseState extends CategoryState {
  List<Movie> getMovies;

  CategoryResponseState(this.getMovies);
}
