import '../../domain/repositories/auth_repository.dart';

class ForgetPasswordUseCase {
  final AuthRepository _repository;

  ForgetPasswordUseCase(this._repository);

  Future<void> execute({required String email}) async {
    return _repository.forgetPassword(email: email);
  }
}