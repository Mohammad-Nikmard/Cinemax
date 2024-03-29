abstract class VideoEvent {}

class FetchTrailerEvent extends VideoEvent {
  String movideID;

  FetchTrailerEvent(this.movideID);
}
