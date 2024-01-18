part of 'playlist_tab_bloc.dart';

@freezed
class PlaylistTabState with _$PlaylistTabState {
  const factory PlaylistTabState.initial({
    List<MyPlaylistsData>? listMyPlaylists,
  }) = PlaylistTabInitialState;
  const factory PlaylistTabState.loading() = PlaylistTabLoadingState;
}
