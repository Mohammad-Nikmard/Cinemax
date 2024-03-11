import 'package:cinemax/bloc/authentication/authentication_event.dart';
import 'package:cinemax/bloc/authentication/authentication_state.dart';
import 'package:cinemax/data/repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository _authenticationRepository;

  AuthBloc(this._authenticationRepository) : super(AuthInitState()) {
    on<AuthRegisterEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        var response = await _authenticationRepository.register(
            event.email, event.username, event.password, event.passwordConfirm);
        emit(AuthResponseState(response));
      },
    );
    on<AuthLoginEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        var response =
            await _authenticationRepository.login(event.password, event.email);
        emit(AuthResponseState(response));
      },
    );
  }
}
