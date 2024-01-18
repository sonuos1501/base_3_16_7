part of 'message_detail_bloc.dart';

@freezed
class MessageDetailEvent with _$MessageDetailEvent {
  const factory MessageDetailEvent.started() = _Started;
  const factory MessageDetailEvent.hasMessage({bool? hasMessage}) = MessageDetailHasMessageEvent;
  const factory MessageDetailEvent.addMsg({MessageModel? msg}) = MessageDetailAddMsgEvent;
}
