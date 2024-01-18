import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'two_factor_authen_event.dart';
part 'two_factor_authen_state.dart';
part 'two_factor_authen_bloc.freezed.dart';

class TwoFactorAuthenBloc extends Bloc<TwoFactorAuthenEvent, TwoFactorAuthenState> {
  TwoFactorAuthenBloc() : super(const TwoFactorAuthenState.initial()) {
    on<Turned>(_turn);
  }

  Future<void> _turn(Turned event, Emitter<TwoFactorAuthenState> emit) async {
    return emit(TwoFactorAuthenState.turnTwoFactorAuth(turn: event.turned));
  }
}
