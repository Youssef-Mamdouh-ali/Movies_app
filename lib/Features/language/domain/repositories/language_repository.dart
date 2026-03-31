abstract class LanguageRepository {
  Future<void> changeLanguage(String code);
  String getSavedLanguage();
}