import 'package:cinemax/bloc/profile/profile_event.dart';
import 'package:cinemax/bloc/profile/profile_state.dart';
import 'package:cinemax/data/repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthenticationRepository _authenticationRepository;
  ProfileBloc(this._authenticationRepository) : super(ProfileIniState()) {
    on<UpdateDataEvent>(
      (event, emit) async {
        emit(ProfileLoadingState());
        var response =
            await _authenticationRepository.updateData(event.file, event.id);
        response.fold((l) => print(l), (r) => print(r));
        emit(ProfileResponseState());
      },
    );
  }
}
