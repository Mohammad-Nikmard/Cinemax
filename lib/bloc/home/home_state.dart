import 'package:cinemax/data/model/banner.dart';
import 'package:cinemax/data/model/category.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/data/model/user.dart';
import 'package:dartz/dartz.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeResponseState extends HomeState {
  Either<String, UserApp> currentUser;
  Either<String, List<BannerModel>> getBanners;
  Either<String, List<Movie>> getForYouSeries;
  Either<String, List<Movie>> getHottestSeries;
  Either<String, List<Movie>> getForYouMovies;
  Either<String, List<Movie>> getLatestMovies;
  Either<String, List<Movie>> getHottestMovies;
  Either<String, List<Movie>> getShortSeries;
  Either<String, List<CategoryModel>> getCategories;

  HomeResponseState(
    this.currentUser,
    this.getBanners,
    this.getForYouSeries,
    this.getHottestSeries,
    this.getForYouMovies,
    this.getHottestMovies,
    this.getLatestMovies,
    this.getShortSeries,
    this.getCategories,
  );
}
