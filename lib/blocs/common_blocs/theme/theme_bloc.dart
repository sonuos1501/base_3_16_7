import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/repository.dart';
part 'theme_bloc.freezed.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(this._repository) : super(const ThemeState.theme(isDarkMode: true)) {
    on<ChangedBrightnessToDark>(_changeBrightnessToDark);
    _init();
  }

  final Repository _repository;

  Future<void> _init() async {
    add(ThemeEvent.changedBrightnessToDark(isDarkMode: await _repository.isDarkMode));
  }

  Future<void> _changeBrightnessToDark(ChangedBrightnessToDark event, Emitter<ThemeState> emit) async {
    emit(ThemeState.theme(isDarkMode: event.isDarkMode));
    await _repository.changeBrightnessToDark(value: event.isDarkMode);
    return;
  }
}
