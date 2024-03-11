import 'package:cinemax/data/model/gallery.dart';
import 'package:dartz/dartz.dart';

abstract class MoviesState {}

class MoviesInitState extends MoviesState {}

class MoviesLoadingState extends MoviesState {}

class MoviesresponseState extends MoviesState {
  Either<String, List<Moviesgallery>> getPhotos;

  MoviesresponseState(this.getPhotos);
}
