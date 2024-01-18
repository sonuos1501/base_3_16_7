// import 'package:flutter/foundation.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'remote_config_state.freezed.dart';
// part 'remote_config_state.g.dart';

// @freezed
// @JsonSerializable(fieldRename: FieldRename.snake)
// abstract class RemoteConfigState with _$RemoteConfigState {
//   const factory RemoteConfigState({
//     NotifyUnderMaintenance? notifyUnderMaintenance,
//     AppUpdate? appForcedUpdate,
//     AppUpdate? appOptionalUpdate,
//     NotifyNewTermsOfService? notifyNewTermsOfService,
//   }) = _RemoteConfigState;

//   const RemoteConfigState._();
//   factory RemoteConfigState.fromJson(Map<String, dynamic> json) =>
//       _$RemoteConfigStateFromJson(json);
// }

// @JsonSerializable(fieldRename: FieldRename.snake)
// @freezed
// abstract class NotifyUnderMaintenance with _$NotifyUnderMaintenance {
//   const factory NotifyUnderMaintenance({
//     bool? active,
//     Dialog? dialog,
//   }) = _NotifyUnderMaintenance;

//   const NotifyUnderMaintenance._();
//   factory NotifyUnderMaintenance.fromJson(Map<String, dynamic> json) =>
//       _$NotifyUnderMaintenanceFromJson(json);
// }

// @freezed
// @JsonSerializable(fieldRename: FieldRename.snake)
// abstract class AppUpdate with _$AppUpdate {
//   const factory AppUpdate({
//     AppUpdateConfig? ios,
//     AppUpdateConfig? android,
//   }) = _AppUpdate;

//   const AppUpdate._();

//   factory AppUpdate.fromJson(Map<String, dynamic> json) =>
//       _$AppUpdateFromJson(json);
// }

// @freezed
// @JsonSerializable(fieldRename: FieldRename.snake)
// abstract class AppUpdateConfig with _$AppUpdateConfig {
//   const factory AppUpdateConfig({
//     String? version,
//     Dialog? dialog,
//   }) = _AppUpdateConfig;

//   const AppUpdateConfig._();
//   factory AppUpdateConfig.fromJson(Map<String, dynamic> json) =>
//       _$AppUpdateConfigFromJson(json);
// }

// @freezed
// @JsonSerializable(fieldRename: FieldRename.snake)
// abstract class NotifyNewTermsOfService with _$NotifyNewTermsOfService {
//   const factory NotifyNewTermsOfService({
//     DateTime? updatedAt,
//     Dialog? dialog,
//   }) = _NotifyNewTermsOfService;

//   const NotifyNewTermsOfService._();
//   factory NotifyNewTermsOfService.fromJson(Map<String, dynamic> json) =>
//       _$NotifyNewTermsOfServiceFromJson(json);
// }

// @freezed
// @JsonSerializable(fieldRename: FieldRename.snake)
// abstract class Dialog with _$Dialog {
//   const factory Dialog({
//     DialogConfig? ja,
//   }) = _Dialog;

//   const Dialog._();

//   factory Dialog.fromJson(Map<String, dynamic> json) => _$DialogFromJson(json);
// }

// @freezed
// @JsonSerializable(fieldRename: FieldRename.snake)
// abstract class DialogConfig with _$DialogConfig {
//   const factory DialogConfig({
//     String? title,
//     String? message,
//     String? actionRetry,
//     String? actionUpdate,
//     String? actionCancel,
//     String? actionAgree,
//   }) = _DialogConfig;

//   const DialogConfig._();

//   factory DialogConfig.fromJson(Map<String, dynamic> json) =>
//       _$DialogConfigFromJson(json);
// }
