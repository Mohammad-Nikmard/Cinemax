import 'package:cinemax/data/datasource/banner_datasource.dart';
import 'package:cinemax/data/datasource/movie_datasource.dart';
import 'package:cinemax/data/repository/banner_repository.dart';
import 'package:cinemax/data/repository/movie_repository.dart';
import 'package:cinemax/util/dio_handler.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.instance;

Future<void> initServiceLoactor() async {
  locator.registerSingleton<Dio>(DioHandler.dioWithoutHeader());

  getDatasources();

  getRepositories();
}

void getDatasources() {
  locator.registerSingleton<BannerDatasource>(
      BannerRemoteDatasource(locator.get()));

  locator
      .registerSingleton<MovieDatasource>(MovieRemoteDatasource(locator.get()));
}

void getRepositories() {
  locator.registerSingleton<BannerRepository>(
      BannerRemoteRepository(locator.get()));

  locator
      .registerSingleton<MovieRepository>(MovieRemoteRpository(locator.get()));
}
