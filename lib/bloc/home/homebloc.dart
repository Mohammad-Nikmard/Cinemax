import 'package:cinemax/bloc/home/home_event.dart';
import 'package:cinemax/bloc/home/home_state.dart';
import 'package:cinemax/data/repository/banner_repository.dart';
import 'package:cinemax/data/repository/movie_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BannerRepository _bannerRepository;
  final MovieRepository _movieRepository;
  HomeBloc(this._bannerRepository, this._movieRepository)
      : super(HomeInitState()) {
    on<HomeDataRequestEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        var getBanners = await _bannerRepository.getBanner();
        var getForYouMovies = await _movieRepository.getForYouMovies();
        var getHottestMovies = await _movieRepository.getHottestMovies();
        var getLatestMovies = await _movieRepository.getLatestMovies();
        var getForYouSeries = await _movieRepository.getForYouSeries();
        var getHottestSeries = await _movieRepository.getHottestSeries();
        emit(HomeResponseState(getBanners, getForYouSeries, getHottestSeries,
            getForYouMovies, getHottestMovies, getLatestMovies));
      },
    );
  }
}
