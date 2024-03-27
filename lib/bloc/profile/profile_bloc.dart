import 'package:cinemax/bloc/profile/profile_event.dart';
import 'package:cinemax/bloc/profile/profile_state.dart';
import 'package:cinemax/data/repository/authentication_repository.dart';
import 'package:cinemax/util/auth_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthenticationRepository _authenticationRepository;
  ProfileBloc(this._authenticationRepository) : super(ProfileIniState()) {
    on<UpdateDataEvent>(
      (event, emit) async {
        emit(ProfileLoadingState());

        await _authenticationRepository.sendImage(event.id, event.file);
        emit(ProfileResponseState());
      },
    );

    on<GetuserEvent>((event, emit) async {
      var response = await _authenticationRepository
          .getCurrentUser(AuthManager.readRecordID());
      emit(UserResponseState(response));
    });

    on<SendFeedbackEvent>(
      (event, emit) async {
        emit(ProfileLoadingState());
        await _authenticationRepository.sendFeedback(event.rate, event.text);
        emit(ProfileResponseState());
      },
    );
  }
}
