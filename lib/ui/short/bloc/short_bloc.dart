import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:theshowplayer/data/repository.dart';

import '../../../models/home/alllistvideos_data.dart';
import '../../../models/short/arguments_like_dislike.dart';
import '../../../models/video_detail_model/video_detail_model.dart';

part 'short_event.dart';
part 'short_state.dart';
part 'short_bloc.freezed.dart';

class ShortBloc extends Bloc<ShortEvent, ShortState> {
  ShortBloc(this._repository) : super(const ShortState.loading()) {
    on<LoadedShortVideos>(_loadedShortVideos);
    on<LikedOrDislikedVideo>(_likedOrDislikedVideo);
  }

  final Repository _repository;

  Future<void> _loadedShortVideos(LoadedShortVideos event, Emitter<ShortState> emit) async {
    try {
      emit(const ShortState.shortVideos(isLoading: true));

      final res = await _repository.getAllListVideos(
        accessToken: await _repository.authToken,
        argumentsAllListVideosData: event.argumentsAllListVideosData,
      );
      final status = res.apiStatus ?? '';

      if (status == HttpStatus.ok.toString()) {
        return emit(
          ShortState.shortVideos(
            shorts: res.data?.short,
            isLoading: false,
          ),
        );
      }

      emit(const ShortState.fail());
    } catch (_) {
      emit(const ShortState.fail());
    }
  }

  Future<void> _likedOrDislikedVideo(LikedOrDislikedVideo event, Emitter<ShortState> emit) async {
    try {
      emit(const ShortState.loading());

      final res = await _repository.likeAndDislikeVideo(accessToken: await _repository.authToken, argumentsLikeDislike: event.argumentsLikeDislike);
      final status = res.apiStatus ?? '';

      if (status == HttpStatus.ok.toString()) {
        return emit(ShortState.likeDislikeVideo(successType: res.successType));
      }

      emit(ShortState.fail(error: res.errors?.errorText));
    } catch (e) {
      emit(ShortState.fail(error: e.toString()));
    }
  }
}
