part of 'channel_bloc.dart';

@freezed
class ChannelState with _$ChannelState {
  const factory ChannelState.loading() = ChannelLoadingState;
  const factory ChannelState.initial({
    List<FilterByProperties>? listFilterByProperties,
    List<FilterByDatetime>? listFilterByDatetime,
    List<Channels>? listChannels,
  }) = ChannelInitialState;

  const factory ChannelState.filterByProperty({
    @Default(FilterByProperties.views) FilterByProperties filterByProperty,
  }) = ChannelFilterByPropertyState;

  const factory ChannelState.filterByDatetime({
    @Default(FilterByDatetime.allTime) FilterByDatetime filterByDatetime,
  }) = ChannelFilterByDatetimeState;
}
