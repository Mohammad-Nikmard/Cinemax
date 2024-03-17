import 'package:cinemax/bloc/splash/splash_event.dart';
import 'package:cinemax/bloc/splash/splash_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitState()) {
    on<CheckConnectionEvent>(
      (event, emit) async {
        emit(SplashLoadingState());
        await Future.delayed(const Duration(seconds: 2), () async {
          final result = await Connectivity().checkConnectivity();
          switch (result) {
            case ConnectivityResult.mobile:
              emit(SplashResponseState());
            case ConnectivityResult.wifi:
              emit(SplashResponseState());
            case ConnectivityResult.none:
              emit(SplashErrorState());
            default:
              emit(SplashInitState());
          }
        });
      },
    );
  }
}
