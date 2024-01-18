part of 'short_tab_bloc.dart';

@freezed
class ShortTabEvent with _$ShortTabEvent {
  const factory ShortTabEvent.loaded({ required ArgumentsShortData argumentsShortData }) = _Loaded;
}
