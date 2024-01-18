part of 'playlist_tab_bloc.dart';

@freezed
class PlaylistTabEvent with _$PlaylistTabEvent {
  const factory PlaylistTabEvent.loaded({ required ArgumentMyPlaylistsData argumentMyPlaylistsData }) = _Loaded;
}
