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
        var registerResponse = await _authenticationRepository.register(
            event.email, event.username, event.password, event.passwordConfirm);
        emit(AuthRegisterResponseState(registerResponse));
      },
    );
    on<AuthLoginEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        var loginResponse =
            await _authenticationRepository.login(event.password, event.email);
        emit(AuthLoginResponseState(loginResponse));
      },
    );
  }
}
