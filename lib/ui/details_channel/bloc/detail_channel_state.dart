part of 'detail_channel_bloc.dart';

@freezed
class DetailChannelState with _$DetailChannelState {
  const factory DetailChannelState.initial() = _Initial;

  const factory DetailChannelState.moreIntroduce({ @Default(false) bool isMore }) = DetailChannelMoreIntroduceState;

  const factory DetailChannelState.subcribe({ @Default(false) bool isSubcribe }) = DetailChannelSubcribeAndUnsubcribeState;
}
