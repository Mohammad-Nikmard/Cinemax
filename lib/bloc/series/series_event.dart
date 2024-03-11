abstract class SeriesEvent {}

class SeriesDataRequestEvent extends SeriesEvent {
  String seriesId;

  SeriesDataRequestEvent(this.seriesId);
}
