import 'package:cinemax/bloc/home/home_event.dart';
import 'package:cinemax/bloc/home/home_state.dart';
import 'package:cinemax/data/repository/banner_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BannerRepository _bannerRepository;
  HomeBloc(this._bannerRepository) : super(HomeInitState()) {
    on<HomeDataRequestEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        var getBanners = await _bannerRepository.getBanner();
        emit(HomeResponseState(getBanners));
      },
    );
  }
}
