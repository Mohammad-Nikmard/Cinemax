abstract class UpDetailEvent {}

class UpDetailDataRequestEvent extends UpDetailEvent {
  String upId;

  UpDetailDataRequestEvent(this.upId);
}
