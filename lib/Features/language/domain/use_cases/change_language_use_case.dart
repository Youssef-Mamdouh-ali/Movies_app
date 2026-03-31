import 'package:movies_app_project/Features/language/domain/repositories/language_repository.dart';

class ChangeLanguageUseCase {
  final LanguageRepository repository;
  ChangeLanguageUseCase(this.repository);
  Future<void> execute(String code) => repository.changeLanguage(code);
}