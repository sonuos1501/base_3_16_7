import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:theshowplayer/data/repository.dart';
import 'package:theshowplayer/models/channels/short_data.dart';

part 'short_tab_event.dart';
part 'short_tab_state.dart';
part 'short_tab_bloc.freezed.dart';

class ShortTabBloc extends Bloc<ShortTabEvent, ShortTabState> {
  ShortTabBloc(this._repository) : super(const ShortTabState.loading()) {
    on<_Loaded>(_loaded);
  }

  final Repository _repository;

  Future<void> _loaded(_Loaded event, Emitter<ShortTabState> emit) async {
    emit(const ShortTabState.loading());
    final listShort = await _getShortByChannel(argumentsShortData: event.argumentsShortData);
    emit(ShortTabState.initial(
      listShort: listShort,
    ),);
  }

  Future<List<ShortData>> _getShortByChannel({ required ArgumentsShortData argumentsShortData }) async {
    try {
      final res = await _repository.getShortByChannel(accessToken: await _repository.authToken, argumentsShortData: argumentsShortData);
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
