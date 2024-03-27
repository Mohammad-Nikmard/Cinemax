import 'package:cinemax/data/model/comment.dart';
import 'package:cinemax/data/model/episode.dart';
import 'package:cinemax/data/model/moviegallery.dart';
import 'package:cinemax/data/model/series_cast.dart';
import 'package:cinemax/data/model/series_seasons.dart';
import 'package:dartz/dartz.dart';

abstract class SeriesState {}

class SeriesInitState extends SeriesState {}

class SeriesLoadingState extends SeriesState {}

class SeriesResponseState extends SeriesState {
  Either<String, List<SeriesSeasons>> getSeasons;
  Either<String, List<SeriesCasts>> getCasts;
  Either<String, List<Episode>> getEpisodes;
  bool isLiked;
  Either<String, List<Comment>> getComments;
  Either<String, List<Moviesgallery>> getPhotos;

  SeriesResponseState(this.getSeasons, this.getCasts, this.getEpisodes,
      this.isLiked, this.getComments, this.getPhotos);
}
