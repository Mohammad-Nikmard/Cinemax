abstract class MoviesEvent {}

class MoviesDataRequestEvent extends MoviesEvent {
  String movieId;

  MoviesDataRequestEvent(this.movieId);
}
