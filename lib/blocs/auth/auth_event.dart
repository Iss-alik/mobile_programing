abstract class AuthEvent {}

class RegisterEvent extends AuthEvent{
  final String email;
  final String password;

  RegisterEvent(this.email, this.password);
}