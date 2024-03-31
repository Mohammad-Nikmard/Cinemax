abstract class VideoEvent {}

class FetchTrailerEvent extends VideoEvent {
  String movideID;

  FetchTrailerEvent(this.movideID);
}

class FetchUpcomingTrailerEvent extends VideoEvent {
  String upID;

  FetchUpcomingTrailerEvent(this.upID);
}
