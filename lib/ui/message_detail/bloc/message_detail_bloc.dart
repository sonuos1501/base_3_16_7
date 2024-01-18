// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:theshowplayer/models/message/message_model.dart';

import '../../../constants/enum/type_status_items.dart';

part 'message_detail_bloc.freezed.dart';
part 'message_detail_event.dart';
part 'message_detail_state.dart';

class MessageDetailBloc extends Bloc<MessageDetailEvent, MessageDetailState> {
  MessageDetailBloc() : super(const _Initial()) {
    on<MessageDetailHasMessageEvent>(_handleUpdateStatusIconSendMsg);
    on<MessageDetailAddMsgEvent>(_handleSendMsg);
    _init();
  }

  List<MessageModel> listMgs = <MessageModel>[];

  void _init() {
    listMgs = listMessage;
    emit(MessageDetailState.listMessage(listMsg: listMessage));
  }


  void _handleUpdateStatusIconSendMsg(
    MessageDetailHasMessageEvent event,
    Emitter<MessageDetailState> emit,
  ) {
    emit(MessageDetailState.hasMessage(hasMsg: event.hasMessage));
  }

  void _handleSendMsg(
    MessageDetailAddMsgEvent event,
    Emitter<MessageDetailState> emit,
  ) {
    emit(MessageDetailState.listMessage(listMsg: [...listMgs]));

    if (state is MessageDetailListMsgState) {
      final state = this.state as MessageDetailListMsgState;
      if (event.msg != null) {
        emit(
          state.copyWith(
            listMsg: [
              ...?state.listMsg,
              ...[event.msg!]
            ],
          ),
        );

        listMgs.add(event.msg!);
      }
    }
    // emit(MessageDetailState.listMessage(listMsg: [...?event.msg]));
  }
}

final listMessage = <MessageModel>[
  const MessageModel(
    id: '1',
    type: MessageType.text,
    isOwnerMessage: true,
    content: 'hahahahahahahhahahaha',
  ),
  const MessageModel(
    id: '1',
    type: MessageType.text,
    isOwnerMessage: false,
    content: 'nhu nhuwng gi anh noi sao emkhoong nhin vee  ',
  ),
  const MessageModel(
    id: '1',
    type: MessageType.text,
    isOwnerMessage: true,
    content: 'xin em dung nang long anh ta',
  ),
  const MessageModel(
    id: '1',
    type: MessageType.text,
    isOwnerMessage: false,
    content: 'anh khong muon bat cong voi em , neu luc truoc em noi ra anh khong xot xa dem ve em nhu',
  ),
];
