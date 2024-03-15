import 'package:cinemax/data/model/movie.dart';

abstract class SeriesEvent {}

class SeriesDataRequestEvent extends SeriesEvent {
  String seriesId;
  String seriesName;

  SeriesDataRequestEvent(this.seriesId, this.seriesName);
}

class WishlistAddToCartEvent extends SeriesEvent {
  final Movie movie;

  WishlistAddToCartEvent(this.movie);
}

class WishlistDeleteItemEvent extends SeriesEvent {
  final String movieName;

  WishlistDeleteItemEvent(this.movieName);
}

class SeriesEpisodesFetchEvent extends SeriesEvent {
  String seasonId;
  String seriesId;
  String seriesName;

  SeriesEpisodesFetchEvent(this.seasonId, this.seriesId, this.seriesName);
}
