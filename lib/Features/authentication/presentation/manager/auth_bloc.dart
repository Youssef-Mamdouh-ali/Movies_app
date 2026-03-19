import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app_project/Features/authentication/domain/entities/sign_up_request.dart';
import 'package:movies_app_project/Features/authentication/domain/use_cases/forget_password_use_case.dart';
import 'package:movies_app_project/Features/authentication/domain/use_cases/sign_out_use_case.dart';
import 'package:movies_app_project/Features/authentication/domain/use_cases/sign_up_use_case.dart';
import '../../domain/entities/sign_in_request.dart';
import '../../domain/use_cases/sign_in_use_case.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthenticationEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final SignOutUseCase signOutUseCase;

  AuthBloc(
    this.signInUseCase,
    this.signUpUseCase,
    this.forgetPasswordUseCase,
    this.signOutUseCase,
  ) : super(AuthInitialState()) {
    on<AuthenticationEventSignIn>(_onSignInEvent);
    on<AuthenticationEventSignUp>(_onSignUpEvent);
    on<AuthenticationEventForgetPassword>(_onForgetPasswordEvent);
    on<AuthenticationEventSignOut>(_onSignOutEvent);
    on<AuthenticationEventGetUserData>(_onGetUserData);
  }

  Future<void> _onSignInEvent(
    AuthenticationEventSignIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingSignInState());
    try {
      await signInUseCase.execute(data: event.signInRequest);
      emit(SuccessSignInState());
    } catch (e) {
      emit(ErrorSignInState());
    }
  }

  Future<void> _onSignUpEvent(
    AuthenticationEventSignUp event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingSignUpState());
    try {
      await signUpUseCase.execute(data: event.signUpRequest);
      emit(SuccessSignUpState());
    } catch (e) {
      emit(ErrorSignUpState(e.toString()));
    }
  }

  Future<void> _onForgetPasswordEvent(
    AuthenticationEventForgetPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingForgetPasswordState());
    try {
      await forgetPasswordUseCase.execute(email: event.email);
      emit(SuccessForgetPasswordState());
    } catch (e) {
      emit(ErrorForgetPasswordState(e.toString()));
    }
  }

  Future<void> _onSignOutEvent(
    AuthenticationEventSignOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingSignOutState());
    try {
      await signOutUseCase.execute();
      emit(SuccessSignOutState());
    } catch (e) {
      emit(ErrorSignOutState(e.toString()));
    }
  }

  void _onGetUserData(
      AuthenticationEventGetUserData event,
      Emitter<AuthState> emit,
      ) {
    final user = FirebaseAuth.instance.currentUser; // الوصول المباشر لـ Firebase

    if (user != null) {
      emit(SuccessGetUserDataState(
        name: user.displayName ?? "User Name", // الاسم
        photoUrl: user.photoURL ?? "", // رابط الصورة
      ));
    }
  }
}
