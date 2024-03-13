import 'package:cinemax/data/model/movie.dart';

abstract class SeriesEvent {}

class SeriesDataRequestEvent extends SeriesEvent {
  String seriesId;

  SeriesDataRequestEvent(this.seriesId);
}

class WishlistAddToCartEvent extends SeriesEvent {
  final Movie movie;

  WishlistAddToCartEvent(this.movie);
}

class WishlistDeleteItemEvent extends SeriesEvent {
  final String movieName;

  WishlistDeleteItemEvent(this.movieName);
}
