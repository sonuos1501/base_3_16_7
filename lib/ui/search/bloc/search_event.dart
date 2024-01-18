part of 'search_bloc.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.started() = _Started;
  const factory SearchEvent.searching({@Default('') String keySearch}) = SearchingEvent;
  const factory SearchEvent.isSearchingEvent({bool? isSearchingEvent}) = IsSearchingEvent;
}
