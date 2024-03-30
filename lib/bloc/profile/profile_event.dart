import 'dart:io';

abstract class ProfileEvent {}

class SendFileEvent extends ProfileEvent {
  String id;
  File? file;

  SendFileEvent(this.id, this.file);
}

class GetuserEvent extends ProfileEvent {}

class SendFeedbackEvent extends ProfileEvent {
  double rate;
  String text;

  SendFeedbackEvent(this.rate, this.text);
}

class SendNameEvent extends ProfileEvent {
  String id;
  String name;

  SendNameEvent(this.id, this.name);
}
