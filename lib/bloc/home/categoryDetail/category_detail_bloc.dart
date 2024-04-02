import 'package:cinemax/bloc/home/categoryDetail/category_event.dart';
import 'package:cinemax/bloc/home/categoryDetail/category_state.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/data/repository/movie_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDetailBloc extends Bloc<CategoryEvent, CategoryState> {
  final MovieRepository _movieRepository;
  CategoryDetailBloc(this._movieRepository) : super(CategoryInitState()) {
    List<Movie> searchedMovie = [];
    on<CategoryFetchEvent>(
      (event, emit) async {
        emit(CategoryLoadingState());
        var response = await _movieRepository.getAllMovies();
        response.fold(
          (exceptionMessage) {},
          (movieList) {
            searchedMovie = movieList
                .where((element) => element.genre
                    .toLowerCase()
                    .contains(event.category.toLowerCase()))
                .toList();
          },
        );
        emit(CategoryResponseState(searchedMovie));
      },
    );
  }
}
