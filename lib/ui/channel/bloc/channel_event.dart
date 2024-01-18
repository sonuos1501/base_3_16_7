part of 'channel_bloc.dart';

@freezed
class ChannelEvent with _$ChannelEvent {
  const factory ChannelEvent.loaded({ required ArgumentGetTopChannels argumentGetTopChannels }) = _Loaded;

  const factory ChannelEvent.choosedFilterByProperty({
    @Default(FilterByProperties.views) FilterByProperties filterByProperty,
  }) = ChoosedFilterByProperty;

  const factory ChannelEvent.choosedFilterByDatetime({
    @Default(FilterByDatetime.allTime) FilterByDatetime filterByDatetime,
  }) = ChoosedFilterByDatetime;
}
