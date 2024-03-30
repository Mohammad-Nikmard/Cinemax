import 'package:cinemax/bloc/movies/movies_event.dart';
import 'package:cinemax/bloc/movies/movies_state.dart';
import 'package:cinemax/data/model/wishlist_cart.dart';
import 'package:cinemax/data/repository/comment_repository.dart';
import 'package:cinemax/data/repository/movie_repository.dart';
import 'package:cinemax/data/repository/wishlist_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieBloc extends Bloc<MoviesEvent, MoviesState> {
  final MovieRepository _movieRepository;
  final WishlistRepository _wishlistrepository;
  final CommentsRepository _commentsRepository;

  MovieBloc(
      this._movieRepository, this._wishlistrepository, this._commentsRepository)
      : super(MoviesInitState()) {
    on<MoviesDataRequestEvent>(
      (event, emit) async {
        emit(MoviesLoadingState());
        var photoList = await _movieRepository.getPhotos(event.movieId);
        var casts = await _movieRepository.getCastList(event.movieId);
        var isLiked = _wishlistrepository.likedOnList(event.movieName);
        var comments = await _commentsRepository.getComments(event.movieId);
        emit(MoviesresponseState(photoList, casts, isLiked, comments));
      },
    );
    on<WishlistAddToCartEvent>(
      (event, emit) async {
        var cart = WishlistCart(
          event.movie.thumbnail,
          event.movie.name,
          event.movie.genre,
          event.movie.category,
          event.movie.rate,
          event.movie.id,
        );
        await _wishlistrepository.addToCart(cart);
      },
    );
    on<WishlistDeleteItemEvent>(
      (event, emit) async {
        await _wishlistrepository.deleteSelectedItem(event.movieName);
      },
    );
  }
}
