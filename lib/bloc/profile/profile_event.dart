import 'dart:io';

abstract class ProfileEvent {}

class UpdateDataEvent extends ProfileEvent {
  String id;
  File file;

  UpdateDataEvent(this.id, this.file);
}
