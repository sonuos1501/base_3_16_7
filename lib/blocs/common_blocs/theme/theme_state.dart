part of 'theme_bloc.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState.theme({
   @Default(false) bool isDarkMode,
  }) = AppThemeState;

}
