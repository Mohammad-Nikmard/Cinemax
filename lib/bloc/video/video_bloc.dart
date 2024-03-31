import 'package:cinemax/bloc/video/video_event.dart';
import 'package:cinemax/bloc/video/video_state.dart';
import 'package:cinemax/data/repository/video_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository _videoRepository;
  VideoBloc(this._videoRepository) : super(VideoInitState()) {
    on<FetchTrailerEvent>(
      (event, emit) async {
        emit(VideoLoadingState());
        var trailer = await _videoRepository.getVideo(event.movideID);
        emit(VideoResponseState(trailer));
      },
    );
    on<FetchUpcomingTrailerEvent>(
      (event, emit) async {
        emit(VideoLoadingState());
        var trailer = await _videoRepository.getTrailer(event.upID);
        emit(VideoResponseState(trailer));
      },
    );
  }
}
