import 'dart:io';

abstract class ProfileEvent {}

class UpdateDataEvent extends ProfileEvent {
  String id;
  File file;

  UpdateDataEvent(this.id, this.file);
}

class GetuserEvent extends ProfileEvent {}

class SendFeedbackEvent extends ProfileEvent {
  double rate;
  String text;

  SendFeedbackEvent(this.rate, this.text);
}
