abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String message;

  RegisterFailure(this.message);
}

class PasswordVisibilityChanged extends RegisterState {
  final bool isVisible;

  PasswordVisibilityChanged(this.isVisible);
}

class RePasswordVisibilityChanged extends RegisterState {
  final bool isVisible;

  RePasswordVisibilityChanged(this.isVisible);
}
