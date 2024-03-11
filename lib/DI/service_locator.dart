import 'package:cinemax/data/datasource/authentication.dart';
import 'package:cinemax/data/datasource/banner_datasource.dart';
import 'package:cinemax/data/datasource/movie_datasource.dart';
import 'package:cinemax/data/datasource/series_datasource.dart';
import 'package:cinemax/data/datasource/upcomings_datasource.dart';
import 'package:cinemax/data/repository/authentication_repository.dart';
import 'package:cinemax/data/repository/banner_repository.dart';
import 'package:cinemax/data/repository/movie_repository.dart';
import 'package:cinemax/data/repository/series_repository.dart';
import 'package:cinemax/data/repository/upcomings_repository.dart';
import 'package:cinemax/util/dio_handler.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;

Future<void> initServiceLoactor() async {
  locator.registerSingleton<Dio>(DioHandler.dioWithoutHeader());

  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  getDatasources();

  getRepositories();
}

void getDatasources() {
  locator.registerSingleton<BannerDatasource>(
      BannerRemoteDatasource(locator.get()));

  locator
      .registerSingleton<MovieDatasource>(MovieRemoteDatasource(locator.get()));

  locator.registerSingleton<UpcomingsDatasource>(
      UpcomingsRemoteDatasource(locator.get()));

  locator.registerSingleton<SeriesDatasource>(
      SeriesRemoteDatasource(locator.get()));

  locator.registerSingleton<AuthenticationDatasource>(
      AuthenticationRemoteDatasource(locator.get()));
}

void getRepositories() {
  locator.registerSingleton<BannerRepository>(
      BannerRemoteRepository(locator.get()));

  locator
      .registerSingleton<MovieRepository>(MovieRemoteRpository(locator.get()));

  locator.registerSingleton<UpcomingsRepository>(
      UpcomingsRemoteRepository(locator.get()));

  locator.registerSingleton<SeriesRepository>(
      SeriesRemoteRepository(locator.get()));

  locator.registerSingleton<AuthenticationRepository>(
      AuthenticationRemoteRepo(locator.get()));
}
