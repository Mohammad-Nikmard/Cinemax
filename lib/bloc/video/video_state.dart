import 'package:cinemax/data/model/video.dart';
import 'package:dartz/dartz.dart';

abstract class VideoState {}

class VideoInitState extends VideoState {}

class VideoLoadingState extends VideoState {}

class VideoResponseState extends VideoState {
  Either<String, VideoModel> trailer;

  VideoResponseState(this.trailer);
}
