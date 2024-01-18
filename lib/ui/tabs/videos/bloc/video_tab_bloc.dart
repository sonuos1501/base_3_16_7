import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:theshowplayer/data/repository.dart';
import 'package:theshowplayer/models/video_detail_model/video_detail_model.dart';

import '../../../../models/channels/argument_videos_by_channel_data.dart';

part 'video_tab_event.dart';
part 'video_tab_state.dart';
part 'video_tab_bloc.freezed.dart';

class VideoTabBloc extends Bloc<VideoTabEvent, VideoTabState> {
  VideoTabBloc(this._repository) : super(const VideoTabState.loading()) {
    on<_Loaded>(_loaded);
  }

  final Repository _repository;

  Future<void> _loaded(_Loaded event, Emitter<VideoTabState> emit) async {
    emit(const VideoTabState.loading());
    final listVideosByChannelData = await _getVideosByChannel(argumentsVideosByChannelData: event.argumentsVideosByChannelData);
    emit(VideoTabState.initial(
      listVideosByChannelData: listVideosByChannelData,
    ),);
  }

  Future<List<VideoDetailModel>> _getVideosByChannel({ required ArgumentsVideosByChannelData argumentsVideosByChannelData }) async {
    try {
      final res = await _repository.getVideosByChannel(argumentsVideosByChannelData: argumentsVideosByChannelData);
      final status = res.apiStatus ?? '';

      if (status == HttpStatus.ok.toString()) {
        return res.data ?? [];
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

}
