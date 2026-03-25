import 'package:movies_app_project/Features/language/data/data_sources/language_local_data_source.dart';
import 'package:movies_app_project/Features/language/domain/repositories/language_repository.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final LanguageLocalDataSource localDataSource;
  LanguageRepositoryImpl(this.localDataSource);

  @override
  Future<void> changeLanguage(String code) => localDataSource.cacheLanguage(code);

  @override
  String getSavedLanguage() => localDataSource.getSavedLanguage();
}