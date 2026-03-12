import '../../domain/entities/sign_up_request.dart';
import '../../domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  Future<void> execute({required SignUpRequest data}) async {
    return _authRepository.signUp(data: data);
  }
}