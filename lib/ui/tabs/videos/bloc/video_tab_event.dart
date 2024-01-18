part of 'video_tab_bloc.dart';

@freezed
class VideoTabEvent with _$VideoTabEvent {
  const factory VideoTabEvent.loaded({ required ArgumentsVideosByChannelData argumentsVideosByChannelData }) = _Loaded;
}
