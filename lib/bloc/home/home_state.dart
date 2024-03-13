import 'package:cinemax/data/model/banner.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:dartz/dartz.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeResponseState extends HomeState {
  Either<String, List<BannerModel>> getBanners;
  Either<String, List<Movie>> getForYouSeries;
  Either<String, List<Movie>> getHottestSeries;
  Either<String, List<Movie>> getForYouMovies;
  Either<String, List<Movie>> getLatestMovies;
  Either<String, List<Movie>> getHottestMovies;

  HomeResponseState(
      this.getBanners,
      this.getForYouSeries,
      this.getHottestSeries,
      this.getForYouMovies,
      this.getHottestMovies,
      this.getLatestMovies);
}
