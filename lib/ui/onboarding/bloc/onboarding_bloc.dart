import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:theshowplayer/data/repository.dart';
import 'package:theshowplayer/di/action_method_locator.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';
part 'onboarding_bloc.freezed.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc(this._repository) : super(const _Initial()) {
    on<DonedIntruduction>(_donedIntruduction);
  }

  final Repository _repository;


  Future<void> _donedIntruduction(DonedIntruduction event, Emitter<OnboardingState> emit) async {
    try {
      await _repository.saveAppNewIntall(false);
      return;
    } catch (_) {}
  }
}
