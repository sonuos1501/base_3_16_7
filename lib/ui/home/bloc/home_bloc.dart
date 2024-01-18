import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:theshowplayer/data/repository.dart';
import 'package:theshowplayer/models/home/alllistvideos_data.dart';
import 'package:theshowplayer/models/home/categories_data.dart';
import 'package:theshowplayer/models/home/homevideos_data.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._repository) : super(const HomeState.loading()) {
    on<HomeSelectedMenuEvent>(_handleSelectMenu);
    on<LoadedCategories>(_loadedCategories);
    on<LoadedAllListVideos>(_loadedAllListVideos);
    on<LoadedHomeVideos>(_loadedHomeVideos);
    _init();
  }

  final Repository _repository;

  void _init() {
    add(const HomeEvent.loadedCategories());
    add(const HomeEvent.loadedHomeVideos(argumentsHomeVideosData: ArgumentsHomeVideosData()));
  }

  void _handleSelectMenu(HomeSelectedMenuEvent event, Emitter<HomeState> emit) {
    emit(HomeMenuState(currentIndexMenu: event.currentIndexMenu));
    return;
  }

  Future<void> _loadedCategories(LoadedCategories event, Emitter<HomeState> emit) async {
    try {

      final res = await _repository.getCategories();
      final status = res.apiStatus ?? '';

      if (status == HttpStatus.ok.toString()) {
        return emit(HomeState.categories(categoriesData: res.data));
      }

      emit(const HomeState.fail());
    } catch (_) {
      emit(const HomeState.fail());
    }
  }

  Future<void> _loadedAllListVideos(LoadedAllListVideos event, Emitter<HomeState> emit) async {
    try {

      emit(const HomeState.allListVideos(isLoading: true));

      final res = await _repository.getAllListVideos(argumentsAllListVideosData: event.argumentsAllListVideosData);
      final status = res.apiStatus ?? '';

      if (status == HttpStatus.ok.toString()) {
        return emit(
          HomeState.allListVideos(
            isLoading: false,
            categoriesData: res.data,
            page: event.argumentsAllListVideosData.topOffset ??
              event.argumentsAllListVideosData.latestOffset ??
              event.argumentsAllListVideosData.featuredOffset ??
              event.argumentsAllListVideosData.favOffset ??
              1,
          ),
        );
      }

      emit(const HomeState.fail());
    } catch (_) {
      emit(const HomeState.fail());
    }
  }

  Future<void> _loadedHomeVideos(LoadedHomeVideos event, Emitter<HomeState> emit) async {
    try {

      emit(const HomeState.homeVideos(isLoading: true));

      final res = await _repository.getHomeVideos(argumentsHomeVideosData: event.argumentsHomeVideosData);
      final status = res.apiStatus ?? '';

      if (status == HttpStatus.ok.toString()) {
        return emit(HomeState.homeVideos(
          isLoading: false,
          homeVideosData: res.data,
          haveClearData: event.argumentsHomeVideosData.haveClearData,
        ),);
      }

      emit(const HomeState.fail());
    } catch (_) {
      emit(const HomeState.fail());
    }
  }
}
