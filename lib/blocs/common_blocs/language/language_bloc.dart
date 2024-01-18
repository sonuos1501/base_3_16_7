
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/repository.dart';
import '../../../models/language/Language.dart';
import '../../../utils/locale/app_localization.dart';

part 'language_bloc.freezed.dart';
part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
 
  LanguageBloc(this._repository) : super(LanguageState.language(language: _defaultLanguage)) {
    on<ChangedLanguage>(_changedLanguage);
    _init();
  }

  static final _defaultLanguage = Language(code: 'US', locale: 'en', language: 'English');

  final Repository _repository;

  Future<void> _init() async {
    final localLang = await _repository.currentLanguage;
    add(LanguageEvent.changedLanguage(localeLanguage: localLang));
  }

  Future<void> _changedLanguage(ChangedLanguage event, Emitter<LanguageState> emit) async {
    final lang = supportedLanguages.firstWhere(
      (element) => (element.locale?.toLowerCase() ?? '') == event.localeLanguage.toLowerCase(),
      orElse: () => _defaultLanguage,
    );
    emit(LanguageState.language(language: lang));
    await _repository.changeLanguage(event.localeLanguage);
    return;
  }

}
