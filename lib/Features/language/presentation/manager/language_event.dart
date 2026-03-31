sealed class LanguageEvent {}


final class LoadSavedLanguageEvent extends LanguageEvent {}


final class ChangeLanguageEvent extends LanguageEvent {
  final String languageCode;

  ChangeLanguageEvent(this.languageCode);
}