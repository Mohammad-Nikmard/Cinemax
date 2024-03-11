abstract class AuthEvent {}

class AuthRegisterEvent extends AuthEvent {
  String username;
  String email;
  String password;
  String passwordConfirm;

  AuthRegisterEvent(
      this.username, this.email, this.password, this.passwordConfirm);
}

class AuthLoginEvent extends AuthEvent {
  String email;
  String password;

  AuthLoginEvent(this.email, this.password);
}
