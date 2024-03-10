import 'package:cinemax/data/model/banner.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:dartz/dartz.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeResponseState extends HomeState {
  Either<String, List<BannerModel>> getBanners;
  Either<String, List<Movie>> getMovies;
  Either<String, List<Movie>> getSeries;

  HomeResponseState(this.getBanners, this.getMovies, this.getSeries);
}
