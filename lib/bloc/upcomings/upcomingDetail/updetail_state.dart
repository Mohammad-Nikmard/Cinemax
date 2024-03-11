import 'package:cinemax/data/model/upcoming_gallery.dart';
import 'package:dartz/dartz.dart';

abstract class UpDetailState {}

class UpDetailInitState extends UpDetailState {}

class UpDetailLoadingState extends UpDetailState {}

class UpDetailResponseState extends UpDetailState {
  Either<String, List<UpcomingGallery>> getphotos;

  UpDetailResponseState(this.getphotos);
}
