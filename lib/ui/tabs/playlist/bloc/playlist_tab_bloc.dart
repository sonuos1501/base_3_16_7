import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:theshowplayer/data/repository.dart';

import '../../../../models/channels/get_my_playlists_data.dart';

part 'playlist_tab_event.dart';
part 'playlist_tab_state.dart';
part 'playlist_tab_bloc.freezed.dart';

class PlaylistTabBloc extends Bloc<PlaylistTabEvent, PlaylistTabState> {
  PlaylistTabBloc(this._repository) : super(const PlaylistTabState.loading()) {
    on<_Loaded>(_loaded);
  }

  final Repository _repository;


  Future<void> _loaded(_Loaded event, Emitter<PlaylistTabState> emit) async {
    emit(const PlaylistTabState.loading());
    final listMyPlaylist = await _getMyPlaylist(argumentMyPlaylistsData: event.argumentMyPlaylistsData);
    emit(PlaylistTabState.initial(
      listMyPlaylists: listMyPlaylist,
    ),);
  }

  Future<List<MyPlaylistsData>> _getMyPlaylist({ required ArgumentMyPlaylistsData argumentMyPlaylistsData }) async {
    try {
      final res = await _repository.getMyPlaylistByChannel(argumentMyPlaylistsData: argumentMyPlaylistsData);
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
