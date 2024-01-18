
part of 'language_bloc.dart';

@freezed
class LanguageEvent with _$LanguageEvent {
  const factory LanguageEvent.changedLanguage({@Default('en') String localeLanguage}) = ChangedLanguage;
}
