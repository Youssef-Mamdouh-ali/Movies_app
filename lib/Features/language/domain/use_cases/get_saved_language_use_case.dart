import 'package:movies_app_project/Features/language/domain/repositories/language_repository.dart';

class GetSavedLanguageUseCase {
  final LanguageRepository repository;
  GetSavedLanguageUseCase(this.repository);
  String execute() => repository.getSavedLanguage();
}