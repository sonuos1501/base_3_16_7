import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:theshowplayer/models/channels/argument_like_videos_by_channel.dart';

import '../../../../data/repository.dart';
import '../../../../models/video_detail_model/video_detail_model.dart';

part 'like_video_tab_event.dart';
part 'like_video_tab_state.dart';
part 'like_video_tab_bloc.freezed.dart';

class LikeVideoTabBloc extends Bloc<LikeVideoTabEvent, LikeVideoTabState> {
  LikeVideoTabBloc(this._repository) : super(const LikeVideoTabState.loading()) {
    on<LoadedLikeVideos>(_loadedLikeVides);
  }

  final Repository _repository;

  Future<void> _loadedLikeVides(LoadedLikeVideos event, Emitter<LikeVideoTabState> emit) async {
    try {
      emit(const LikeVideoTabState.loading());

      final res = await _repository.getLikedVideoByChannel(
        accessToken: await _repository.authToken,
        argumentsLikeVideosByChannelData: event.argumentsLikeVideosByChannelData,
      );
      final status = res.apiStatus ?? '';

      if (status == HttpStatus.ok.toString()) {
        return emit(LikeVideoTabState.listLikeVideosByChannelData(listVideosByChannelData: res.data ?? []));
      }

      emit(const LikeVideoTabState.fail());
    } catch (e) {
      emit(const LikeVideoTabState.fail());
    }
  }
}
