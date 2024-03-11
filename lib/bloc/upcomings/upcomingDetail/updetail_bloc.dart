import 'package:cinemax/bloc/upcomings/upcomingDetail/updetail_event.dart';
import 'package:cinemax/bloc/upcomings/upcomingDetail/updetail_state.dart';
import 'package:cinemax/data/repository/upcomings_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpDetailBloc extends Bloc<UpDetailEvent, UpDetailState> {
  final UpcomingsRepository _upcomingsRepository;

  UpDetailBloc(this._upcomingsRepository) : super(UpDetailInitState()) {
    on<UpDetailDataRequestEvent>(
      (event, emit) async {
        emit(UpDetailLoadingState());
        var getphotos = await _upcomingsRepository.getPhotos(event.upId);
        var casts = await _upcomingsRepository.getCasts(event.upId);
        emit(UpDetailResponseState(getphotos, casts));
      },
    );
  }
}
