import 'package:cinemax/bloc/home/home_event.dart';
import 'package:cinemax/bloc/home/home_state.dart';
import 'package:cinemax/data/repository/authentication_repository.dart';
import 'package:cinemax/data/repository/banner_repository.dart';
import 'package:cinemax/data/repository/category_repository.dart';
import 'package:cinemax/data/repository/movie_repository.dart';
import 'package:cinemax/util/auth_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BannerRepository _bannerRepository;
  final MovieRepository _movieRepository;
  final CategoryRepository _categoryRepository;
  final AuthenticationRepository _authenticationRepository;
  HomeBloc(this._bannerRepository, this._movieRepository,
      this._authenticationRepository, this._categoryRepository)
      : super(HomeInitState()) {
    on<HomeDataRequestEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        var user = await _authenticationRepository
            .getCurrentUser(AuthManager.readRecordID());
        var getBanners = await _bannerRepository.getBanner();
        var getForYouMovies = await _movieRepository.getForYouMovies();
        var getHottestMovies = await _movieRepository.getHottestMovies();
        var getLatestMovies = await _movieRepository.getLatestMovies();
        var getForYouSeries = await _movieRepository.getForYouSeries();
        var getHottestSeries = await _movieRepository.getHottestSeries();
        var getShortSeries = await _movieRepository.getShortSeries();
        var getCategories = await _categoryRepository.getCategories();
        emit(HomeResponseState(
          user,
          getBanners,
          getForYouSeries,
          getHottestSeries,
          getForYouMovies,
          getHottestMovies,
          getLatestMovies,
          getShortSeries,
          getCategories,
        ));
      },
    );
  }
}
