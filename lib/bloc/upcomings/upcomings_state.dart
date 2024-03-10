import 'package:cinemax/data/model/upcomings.dart';
import 'package:dartz/dartz.dart';

abstract class UpcomingsState {}

class UpcomingsInitState extends UpcomingsState {}

class UpcomingsLoadingState extends UpcomingsState {}

class UpcomingsResponseState extends UpcomingsState {
  Either<String, List<Upcomings>> getUpcomingsList;

  UpcomingsResponseState(this.getUpcomingsList);
}
