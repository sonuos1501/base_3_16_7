
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_bloc.freezed.dart';
part 'live_event.dart';
part 'live_state.dart';

class LiveBloc extends Bloc<LiveEvent, LiveState> {
  LiveBloc() : super(const _Initial()) {
    on<LiveSelectMenuEvent>(_handleSelectMenu);
  }

  void _handleSelectMenu(LiveSelectMenuEvent event, Emitter<LiveState> emit) {
    emit(LiveState.menuState(currentIndexMenu: event.index));
    return;
  }

}
