import 'package:cinemax/data/model/movie_casts.dart';
import 'package:cinemax/data/model/moviegallery.dart';
import 'package:dartz/dartz.dart';

abstract class MoviesState {}

class MoviesInitState extends MoviesState {}

class MoviesLoadingState extends MoviesState {}

class MoviesresponseState extends MoviesState {
  Either<String, List<Moviesgallery>> getPhotos;
  Either<String, List<MovieCasts>> castList;

  MoviesresponseState(this.getPhotos, this.castList);
}
