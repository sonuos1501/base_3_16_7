part of 'detail_channel_bloc.dart';

@freezed
class DetailChannelEvent with _$DetailChannelEvent {
  const factory DetailChannelEvent.moredIntro({ @Default(false) bool moredIntro }) = MoredIntroduce;

  const factory DetailChannelEvent.subcribed({ @Default(false) bool subcribed }) = SubcribedAndUnsubcribed;
}
