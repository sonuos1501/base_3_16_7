import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_channel_event.dart';
part 'detail_channel_state.dart';
part 'detail_channel_bloc.freezed.dart';

class DetailChannelBloc extends Bloc<DetailChannelEvent, DetailChannelState> {
  DetailChannelBloc() : super(const _Initial()) {
    on<MoredIntroduce>(_moredIntroduce);
    on<SubcribedAndUnsubcribed>(_subcribedAndUnsubcribed);
  }

  Future<void> _moredIntroduce(MoredIntroduce event, Emitter<DetailChannelState> emit) async {
    emit(DetailChannelState.moreIntroduce(isMore: event.moredIntro));
    return;
  }

  Future<void> _subcribedAndUnsubcribed(SubcribedAndUnsubcribed event, Emitter<DetailChannelState> emit) async {
    emit(DetailChannelState.subcribe(isSubcribe: event.subcribed));
    return;
  }
}
