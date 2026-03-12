import 'package:movies_app_project/Features/authentication/domain/entities/sign_in_request.dart';
import 'package:movies_app_project/Features/authentication/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  Future<void> execute({required SignInRequest data}) async {
    _authRepository.signIn(data:data);
  }
}