import '../../domain/entities/sign_in_request.dart';
import '../../domain/entities/sign_up_request.dart';

abstract class AuthDataSource {
  Future<void> signIn({required SignInRequest data});
  Future<void> signUp({required SignUpRequest data});
  Future<void> forgetPassword({required String email});
  Future<void> signOut();
}