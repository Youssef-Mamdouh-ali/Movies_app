import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app_project/Features/authentication/domain/entities/sign_up_request.dart';
import 'package:movies_app_project/Features/authentication/domain/use_cases/forget_password_use_case.dart';
import 'package:movies_app_project/Features/authentication/domain/use_cases/sign_up_use_case.dart';
import '../../domain/entities/sign_in_request.dart';
import '../../domain/use_cases/sign_in_use_case.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthenticationEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;

  AuthBloc(this.signInUseCase, this.signUpUseCase, this.forgetPasswordUseCase)
      : super(AuthInitialState()) {
    on<AuthenticationEventSignIn>(_onSignInEvent);
    on<AuthenticationEventSignUp>(_onSignUpEvent);
    on<AuthenticationEventForgetPassword>(_onForgetPasswordEvent);
  }

  Future<void> _onSignInEvent(AuthenticationEventSignIn event,
      Emitter<AuthState> emit) async {
    emit(LoadingSignInState());
    try {
      await signInUseCase.execute(data: event.signInRequest);
      emit(SuccessSignInState());
    } catch (e) {
      emit(ErrorSignInState());
    }
  }

  Future<void> _onSignUpEvent(AuthenticationEventSignUp event,
      Emitter<AuthState> emit) async {
    emit(LoadingSignUpState());
    try {
      await signUpUseCase.execute(data: event.signUpRequest);
      emit(SuccessSignUpState());
    } catch (e) {
      emit(ErrorSignUpState(e.toString()));
    }
  }

  Future<void> _onForgetPasswordEvent(AuthenticationEventForgetPassword event,
      Emitter<AuthState> emit) async {
    emit(LoadingForgetPasswordState());
    try {
      await forgetPasswordUseCase.execute(email: event.email);
      emit(SuccessForgetPasswordState());
    } catch (e) {
      emit(ErrorForgetPasswordState(e.toString()));
    }
  }
}
