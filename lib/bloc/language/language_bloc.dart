import 'package:cinemax/bloc/language/language_event.dart';
import 'package:cinemax/bloc/language/language_state.dart';
import 'package:cinemax/data/model/language.dart';
import 'package:cinemax/util/app_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState()) {
    on<ChangeLanguage>(onChangeLanguage);
    on<GetLanguage>(onGetLanguage);
  }

  onChangeLanguage(event, emit) async {
    AppManager.setLang(
      event.selectedLanguage.value.languageCode,
    );
    emit(state.copyWith(selectedLanguage: event.selectedLanguage));
  }

  onGetLanguage(event, emit) async {
    final selectedLanguage = AppManager.getLnag();
    emit(state.copyWith(
      selectedLanguage: selectedLanguage != null
          ? Language.values
              .where((item) => item.value.languageCode == selectedLanguage)
              .first
          : Language.english,
    ));
  }
}
