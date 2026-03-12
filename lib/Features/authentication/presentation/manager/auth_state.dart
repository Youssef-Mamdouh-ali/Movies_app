part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitialState extends AuthState {
  @override
  List<Object> get props => [];
}

final class LoadingSignInState extends AuthState {
  @override
  List<Object> get props => [];
}

final class SuccessSignInState extends AuthState {
  @override
  List<Object> get props => [];
}

final class ErrorSignInState extends AuthState {
  @override
  List<Object> get props => [];
}
/// sign up
final class LoadingSignUpState extends AuthState {
  @override
  List<Object> get props => [];
}

final class SuccessSignUpState extends AuthState {
  @override
  List<Object> get props => [];
}

final class ErrorSignUpState extends AuthState {
  final String message;
  const ErrorSignUpState(this.message);

  @override
  List<Object> get props => [message];
}


/// forget password
final class LoadingForgetPasswordState extends AuthState {
  @override
  List<Object> get props => [];
}

final class SuccessForgetPasswordState extends AuthState {
  @override
  List<Object> get props => [];
}

final class ErrorForgetPasswordState extends AuthState {
  final String message;
  const ErrorForgetPasswordState(this.message);

  @override
  List<Object> get props => [message];
}