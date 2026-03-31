part of 'auth_bloc.dart';
sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AuthenticationEventSignIn extends AuthenticationEvent {
  SignInRequest signInRequest ;
  AuthenticationEventSignIn({required this.signInRequest});
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class AuthenticationEventSignUp extends AuthenticationEvent {
  final SignUpRequest signUpRequest;
  const AuthenticationEventSignUp({required this.signUpRequest});

  @override
  List<Object?> get props => [signUpRequest];
}

class AuthenticationEventForgetPassword extends AuthenticationEvent {
  final String email;
  const AuthenticationEventForgetPassword({required this.email});

  @override
  List<Object?> get props => [email];
}


class AuthenticationEventSignOut extends AuthenticationEvent {
  @override
  List<Object?> get props => [];

}


class AuthenticationEventGetUserData extends AuthenticationEvent {
  const AuthenticationEventGetUserData();
  @override
  List<Object?> get props => [];
}