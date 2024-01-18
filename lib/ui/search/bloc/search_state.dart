part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;
  const factory SearchState.search({@Default([]) List<VideoDetailModel> listSearchVideos,String? keySearch, @Default(false) bool isLoading}) = SearchingState;
  const factory SearchState.isSearchingState({bool? isSearch}) = IsSearchingState;
}
