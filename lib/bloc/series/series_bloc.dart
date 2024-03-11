import 'package:cinemax/bloc/series/series_event.dart';
import 'package:cinemax/bloc/series/series_state.dart';
import 'package:cinemax/data/repository/series_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  final SeriesRepository _seriesRepository;
  SeriesBloc(this._seriesRepository) : super(SeriesInitState()) {
    on<SeriesDataRequestEvent>(
      (event, emit) async {
        emit(SeriesLoadingState());
        var getSeasons = await _seriesRepository.getSeasons(event.seriesId);
        var casts = await _seriesRepository.getSeriesCast(event.seriesId);
        emit(SeriesResponseState(getSeasons, casts));
      },
    );
  }
}
