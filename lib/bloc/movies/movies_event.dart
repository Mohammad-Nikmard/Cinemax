import 'package:cinemax/data/model/movie.dart';

abstract class MoviesEvent {}

class MoviesDataRequestEvent extends MoviesEvent {
  String movieId;

  MoviesDataRequestEvent(this.movieId);
}

class WishlistAddToCartEvent extends MoviesEvent {
  final Movie movie;

  WishlistAddToCartEvent(this.movie);
}
