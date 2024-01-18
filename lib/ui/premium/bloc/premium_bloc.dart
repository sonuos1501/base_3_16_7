import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:theshowplayer/data/repository.dart';
import 'package:theshowplayer/models/premiums/argument_most_buy_videos.dart';

import '../../../models/home/alllistvideos_data.dart';
import '../../../models/home/channel_might_like.dart';
import '../../../models/video_detail_model/video_detail_model.dart';

part 'premium_event.dart';
part 'premium_state.dart';
part 'premium_bloc.freezed.dart';

class PremiumBloc extends Bloc<PremiumEvent, PremiumState> {
  PremiumBloc(this._repository) : super(const PremiumState.loading()) {
    on<LoadedMostBuyVideos>(_loadedMostBuyVideos);
    on<LoadedChannelYouMightLike>(_loadedChannelYouMightLike);
  }

  final Repository _repository;

  Future<void> _loadedMostBuyVideos(LoadedMostBuyVideos event, Emitter<PremiumState> emit) async {
    try {
      emit(const PremiumState.loading());

      final res = await _repository.getMostBuyVideos(
        argumentsMostBuyVideosData: event.argumentsMostBuyVideosData,
      );
      final status = res.apiStatus ?? '';

      if (status == HttpStatus.ok.toString()) {
        return emit(PremiumState.listMostBuyVideos(
          listMostBuyVideos: res.data ?? [],
          page: event.argumentsMostBuyVideosData.offset,
          haveClearData: event.argumentsMostBuyVideosData.haveClearData,
        ),);
      }

      emit(const PremiumState.fail());
    } catch (e) {
      emit(const PremiumState.fail());
    }
  }

  Future<void> _loadedChannelYouMightLike(LoadedChannelYouMightLike event, Emitter<PremiumState> emit) async {
    try {
      emit(const PremiumState.loading());

      final res = await _repository.getAllListVideos(
        accessToken: await _repository.authToken,
        argumentsAllListVideosData: event.argumentsAllListVideosData,
      );
      final status = res.apiStatus ?? '';

      if (status == HttpStatus.ok.toString()) {
        return emit(
          PremiumState.listChannelYouMightLike(listChannelYouMightLike: res.data?.channelMightLike ?? []),
        );
      }

      emit(const PremiumState.fail());
    } catch (_) {
      emit(const PremiumState.fail());
    }
  }
}
