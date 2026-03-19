  import 'package:shared_preferences/shared_preferences.dart';

abstract class LanguageLocalDataSource {
  Future<bool> cacheLanguage(String languageCode);
  String getSavedLanguage();
}

class LanguageLocalDataSourceImpl implements LanguageLocalDataSource {
  final SharedPreferences sharedPreferences;
  LanguageLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<bool> cacheLanguage(String languageCode) async {
    return await sharedPreferences.setString('LOCALE', languageCode);
  }

  @override
  String getSavedLanguage() {
    return sharedPreferences.getString('LOCALE') ?? 'en';
  }
}