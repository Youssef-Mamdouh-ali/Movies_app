import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_project/Features/language/domain/use_cases/change_language_use_case.dart';
import 'package:movies_app_project/Features/language/domain/use_cases/get_saved_language_use_case.dart';
import 'package:movies_app_project/Features/language/presentation/manager/language_event.dart';
import 'package:movies_app_project/Features/language/presentation/manager/language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final ChangeLanguageUseCase changeLanguageUseCase;
  final GetSavedLanguageUseCase getSavedLanguageUseCase;

  LanguageBloc(this.changeLanguageUseCase, this.getSavedLanguageUseCase)
      : super( LanguageState(Locale('en'))) {

    on<LoadSavedLanguageEvent>((event, emit) {
      final code = getSavedLanguageUseCase.execute();
      emit(LanguageState(Locale(code)));
    });

    on<ChangeLanguageEvent>((event, emit) async {

      await changeLanguageUseCase.execute(event.languageCode);

      emit(LanguageState(Locale(event.languageCode)));
    });
  }
}