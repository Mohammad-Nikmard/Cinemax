import 'package:cinemax/data/model/upcoming_cast.dart';
import 'package:cinemax/data/model/upcoming_gallery.dart';
import 'package:dartz/dartz.dart';

abstract class UpDetailState {}

class UpDetailInitState extends UpDetailState {}

class UpDetailLoadingState extends UpDetailState {}

class UpDetailResponseState extends UpDetailState {
  Either<String, List<UpcomingGallery>> getphotos;
  Either<String, List<UpcomingsCasts>> casts;

  UpDetailResponseState(this.getphotos, this.casts);
}
