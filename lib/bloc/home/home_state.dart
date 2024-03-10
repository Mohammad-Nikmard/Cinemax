import 'package:cinemax/data/model/banner.dart';
import 'package:dartz/dartz.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeResponseState extends HomeState {
  Either<String, List<BannerModel>> getBanners;

  HomeResponseState(this.getBanners);
}
