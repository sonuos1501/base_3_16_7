
// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'env_state.freezed.dart';

@freezed
class EnvState with _$EnvState {

  const factory EnvState({
    required String serverKey,
    required String baseUrlApi,
  }) = _EnvState;
  const EnvState._();
}

class EnvValue {

  static late EnvState env;

  static const EnvState development = EnvState(
    baseUrlApi: 'https://theshow.sendme.kr',
    serverKey: '4ed641bf663c844728ae1ec0a1d2e495',
  );

  static const EnvState production = EnvState(
    baseUrlApi: 'https://theshowplus.com',
    serverKey: '0e4efc7abb992e8dd8b3bc5629b1325c',
  );

  static const EnvState staging = EnvState(baseUrlApi: 'staging', serverKey: '');

}
