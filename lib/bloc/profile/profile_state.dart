import 'package:cinemax/data/model/usera.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileState {}

class ProfileResponseState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileIniState extends ProfileState {}

class UserResponseState extends ProfileState {
  Either<String, UserApp> user;

  UserResponseState(this.user);
}
