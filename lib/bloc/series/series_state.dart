import 'package:cinemax/data/model/series_seasons.dart';
import 'package:dartz/dartz.dart';

abstract class SeriesState {}

class SeriesInitState extends SeriesState {}

class SeriesLoadingState extends SeriesState {}

class SeriesResponseState extends SeriesState {
  Either<String, List<SeriesSeasons>> getSeasons;

  SeriesResponseState(this.getSeasons);
}
