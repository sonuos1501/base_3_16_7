
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:theshowplayer/data/repository.dart';

import '../../../constants/enum/filter_by_datetime.dart';
import '../../../constants/enum/filter_by_properties.dart';
import '../../../models/channels/response_get_top_channels.dart';

part 'channel_event.dart';
part 'channel_state.dart';
part 'channel_bloc.freezed.dart';

class ChannelBloc extends Bloc<ChannelEvent, ChannelState> {
  ChannelBloc(this._repository) : super(const ChannelState.loading()) {
    on<_Loaded>(_loaded);
    on<ChoosedFilterByProperty>(_choosedFilterByProperty);
    on<ChoosedFilterByDatetime>(_choosedFilterByDatetime);
  }

  final Repository _repository;

  final _listFilterByProperties = [
    FilterByProperties.views,
    FilterByProperties.subscribers,
    FilterByProperties.mostActive,
  ];

  final _listFilterByDatetime = [
    FilterByDatetime.today,
    FilterByDatetime.thisWeek,
    FilterByDatetime.thisMonth,
    FilterByDatetime.thisYear,
    FilterByDatetime.allTime,
  ];


  Future<void> _loaded(_Loaded event, Emitter<ChannelState> emit) async {
    emit(const ChannelState.loading());
    final topChannels = await _getTopChannel(argumentGetTopChannels: event.argumentGetTopChannels);
    emit(ChannelState.initial(
      listFilterByProperties: _listFilterByProperties,
      listFilterByDatetime: _listFilterByDatetime,
      listChannels: topChannels,
    ),);
  }

  Future<void> _choosedFilterByProperty(ChoosedFilterByProperty event, Emitter<ChannelState> emit) async {
    return emit(ChannelState.filterByProperty(filterByProperty: event.filterByProperty));
  }

  Future<void> _choosedFilterByDatetime(ChoosedFilterByDatetime event, Emitter<ChannelState> emit) async {
    return emit(ChannelState.filterByDatetime(filterByDatetime: event.filterByDatetime));
  }

  Future<List<Channels>> _getTopChannel({ required ArgumentGetTopChannels argumentGetTopChannels }) async {
    try {
      final res = await _repository.getTopChannel(
        token: await _repository.authToken,
        argumentGetTopChannels: argumentGetTopChannels,
      );
      final status = res.apiStatus ?? '';

      if (status == HttpStatus.ok.toString()) {
        return res.channels ?? [];
      } else {
        return [];
      }

    } catch (e) {
      return [];
    }
  }

}
