import 'package:movies_app_project/Features/authentication/domain/entities/sign_in_request.dart';
import 'package:movies_app_project/Features/authentication/domain/entities/sign_up_request.dart';

abstract class AuthRepository {

  Future<void> signIn({required SignInRequest data });
  Future<void> signUp({required SignUpRequest data});
  Future<void> forgetPassword({required String email});
  Future<void> signOut();
}