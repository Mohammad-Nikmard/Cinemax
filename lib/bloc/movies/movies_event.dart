import 'package:cinemax/data/model/movie.dart';

abstract class MoviesEvent {}

class MoviesDataRequestEvent extends MoviesEvent {
  String movieId;
  String movieName;

  MoviesDataRequestEvent(this.movieId, this.movieName);
}

class WishlistAddToCartEvent extends MoviesEvent {
  final Movie movie;

  WishlistAddToCartEvent(this.movie);
}

class WishlistDeleteItemEvent extends MoviesEvent {
  final String movieName;

  WishlistDeleteItemEvent(this.movieName);
}
