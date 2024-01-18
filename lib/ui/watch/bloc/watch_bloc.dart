
// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:theshowplayer/data/repository.dart';

import '../../../models/video_detail_model/video_detail_model.dart';

part 'watch_bloc.freezed.dart';
part 'watch_event.dart';
part 'watch_state.dart';

class WatchBloc extends Bloc<WatchEvent, WatchState> {
  WatchBloc(this._repository, { required this.videoId }) : super(const _Initial()) {
    on<AutoPlayWatchEvent>(_handleAutoPlay);
    _init();
  }

  final Repository _repository;

  final String videoId;

  Future<void> _init() async {
    //  await getVideoDetail();
  }

  void _handleAutoPlay(AutoPlayWatchEvent event, Emitter<WatchState> emit) {
    emit(WatchState.autoPlay(autoPlay: event.autoPlay));
    return;
  }

  Future<void> getVideoDetail() async {
    try {
      final res = await _repository.getVideoDetail(videoId: videoId);
      final status = res.apiStatus ?? '';

      if (status == HttpStatus.ok.toString()) {
        emit(WatchState.video(video: res.data));
      }
    } catch (_) {}
  }
}
