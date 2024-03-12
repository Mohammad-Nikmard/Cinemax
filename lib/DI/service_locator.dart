import 'package:cinemax/bloc/wishlist/wishlist_bloc.dart';
import 'package:cinemax/data/datasource/authentication.dart';
import 'package:cinemax/data/datasource/banner_datasource.dart';
import 'package:cinemax/data/datasource/movie_datasource.dart';
import 'package:cinemax/data/datasource/search_datasource.dart';
import 'package:cinemax/data/datasource/series_datasource.dart';
import 'package:cinemax/data/datasource/upcomings_datasource.dart';
import 'package:cinemax/data/datasource/wishlist_datasource.dart';
import 'package:cinemax/data/repository/authentication_repository.dart';
import 'package:cinemax/data/repository/banner_repository.dart';
import 'package:cinemax/data/repository/movie_repository.dart';
import 'package:cinemax/data/repository/search_repository.dart';
import 'package:cinemax/data/repository/series_repository.dart';
import 'package:cinemax/data/repository/upcomings_repository.dart';
import 'package:cinemax/data/repository/wishlist_repository.dart';
import 'package:cinemax/util/dio_handler.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;

Future<void> initServiceLoactor() async {
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  locator.registerSingleton<Dio>(DioHandler.dioWithoutHeader());

  getDatasources();

  getRepositories();

  locator.registerSingleton<WishlistBloc>(WishlistBloc(locator.get()));
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

  locator.registerSingleton<SearchDatasource>(
      SearchRemoteDatasource(locator.get()));

  locator.registerSingleton<WishlistDatasource>(WishlistLocalDatasource());
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

  locator.registerSingleton<SearchRepository>(
      SearchRemoteRepository(locator.get()));

  locator.registerSingleton<WishlistRepository>(
      WishlistLocalRepository(locator.get()));
}
