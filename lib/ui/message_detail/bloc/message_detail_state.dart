part of 'message_detail_bloc.dart';

@freezed
class MessageDetailState with _$MessageDetailState {
  const factory MessageDetailState.initial() = _Initial;
  const factory MessageDetailState.hasMessage({@Default(false) hasMsg}) = MessageDetailHasMsgState;
  const factory MessageDetailState.listMessage({List<MessageModel>? listMsg}) = MessageDetailListMsgState;
}
