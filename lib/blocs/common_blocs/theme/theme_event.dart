part of 'theme_bloc.dart';

@freezed
class ThemeEvent with _$ThemeEvent {
  const factory ThemeEvent.changedBrightnessToDark({@Default(false) bool isDarkMode}) = ChangedBrightnessToDark;
}
