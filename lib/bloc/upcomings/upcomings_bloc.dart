import 'package:cinemax/bloc/upcomings/upcomings_event.dart';
import 'package:cinemax/bloc/upcomings/upcomings_state.dart';
import 'package:cinemax/data/repository/upcomings_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingsBloc extends Bloc<UpcomingsEvent, UpcomingsState> {
  final UpcomingsRepository _upcomingsRepository;
  UpcomingsBloc(this._upcomingsRepository) : super(UpcomingsInitState()) {
    on<UpcomingsDataRequestEvent>(
      (event, emit) async {
        emit(UpcomingsLoadingState());
        var getList = await _upcomingsRepository.getUpcomingsList();
        emit(UpcomingsResponseState(getList));
      },
    );
  }
}
