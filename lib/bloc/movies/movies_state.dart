import 'package:cinemax/data/model/comment.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/data/model/movie_casts.dart';
import 'package:cinemax/data/model/moviegallery.dart';
import 'package:dartz/dartz.dart';

abstract class MoviesState {}

class MoviesInitState extends MoviesState {}

class MoviesLoadingState extends MoviesState {}

class MoviesresponseState extends MoviesState {
  Either<String, List<Moviesgallery>> getPhotos;
  Either<String, List<MovieCasts>> castList;
  bool isLiked;
  Either<String, List<Comment>> getComments;
  Either<String, List<Movie>> getRelateds;

  MoviesresponseState(this.getPhotos, this.castList, this.isLiked,
      this.getComments, this.getRelateds);
}
