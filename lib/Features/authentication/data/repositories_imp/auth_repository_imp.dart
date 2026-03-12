import 'package:movies_app_project/Features/authentication/data/data_source/auth_data_source.dart';
import 'package:movies_app_project/Features/authentication/domain/entities/sign_in_request.dart';
import 'package:movies_app_project/Features/authentication/domain/entities/sign_up_request.dart';
import 'package:movies_app_project/Features/authentication/domain/repositories/auth_repository.dart';
class AuthRepositoryImp implements AuthRepository {
  ///call data source
final AuthDataSource _authDataSource;
AuthRepositoryImp(this._authDataSource);

  @override
  Future<void> signIn({required SignInRequest data}) {

   return _authDataSource.signIn(data: data);
  }

  @override
  Future<void> signUp({required SignUpRequest data}) {
    return _authDataSource.signUp(data: data);
  }
@override
Future<void> forgetPassword({required String email}) {
  return _authDataSource.forgetPassword(email: email);
}
}