import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/transformers.dart';
import 'package:theshowplayer/data/repository.dart';
import 'package:theshowplayer/models/search_model/search_model.dart';

import '../../../models/video_detail_model/video_detail_model.dart';

part 'search_bloc.freezed.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._repository) : super(const _Initial()) {
    on<SearchingEvent>(
      _handleSearch,
      transformer: debounce(const Duration(milliseconds: 400)),
    );
    on<IsSearchingEvent>(_handleIsSearching);
  }

  final Repository _repository;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  void _handleIsSearching(IsSearchingEvent event, Emitter<SearchState> emit) {
    emit(IsSearchingState(isSearch: event.isSearchingEvent));
  }

  final listTemp = [
    'data1',
    'haha',
    'khong',
    'co',
    'gi',
    'la',
    'khong',
    'the',
  ];

  Future<void> _handleSearch(
    SearchingEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (event.keySearch == '') {
      emit(
        SearchState.search(listSearchVideos: [], keySearch: event.keySearch),
      );
    }

    final args = SearchVideoArguments(
      keySearch: event.keySearch,
      token: await _repository.authToken,
    );

    try {
      emit(const SearchState.search(isLoading: true));

      final listSearchVideos = await _repository.fetchListSearchVideos(
        keySearch: event.keySearch,
        args: args,
      );

      final status = listSearchVideos.apiStatus ?? '';

      if (status == HttpStatus.ok.toString() &&
          (listSearchVideos.data ?? []).isNotEmpty) {
        emit(
          SearchState.search(
            listSearchVideos: listSearchVideos.data ?? [],
            keySearch: event.keySearch,
            isLoading: false,
          ),
        );

        return;
      }

      emit(
        SearchState.search(
          listSearchVideos: [],
          isLoading: false,
          keySearch: event.keySearch,
        ),
      );
      return;
    } catch (e) {
      return;
    }
  }
}
