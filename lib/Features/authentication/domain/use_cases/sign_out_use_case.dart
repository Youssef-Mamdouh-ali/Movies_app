import 'package:movies_app_project/Features/authentication/domain/repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository _repository;
  SignOutUseCase(this._repository);

  Future<void> execute() async {
    return await _repository.signOut();
  }
}