// ignore_for_file: lines_longer_than_80_chars
// import 'dart:convert';
// import 'dart:io';


// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:notifier_base/Datas/Shared_preferences/shared_preferences.dart';
// import 'package:notifier_base/Datas/env/env_state.dart';
// import 'package:notifier_base/Utils/app_link_opener.dart';
// import 'package:notifier_base/Utils/remote_config_state.dart';
// import 'package:package_info/package_info.dart';
// import 'package:version/version.dart';

// // ignore: avoid_classes_with_only_static_members
// class RemoteConfigUtil {
//   static Future<void> verifyRemoteConfigurations({
//     @required BuildContext? context,
//     @required SharedPreferencesClient? prefs,
//     @required EnvState? envState,
//     bool maintenance = false,
//     bool appUpdate = false,
//     bool newTermsOfService = false,
//   }) async {
//     final config = await _fetch(envState);
//     if (config == null) {
//       // cannot check it.
//       return;
//     }
//     debugPrint('config $config');

//     if (maintenance) {
//       await _showMaintenanceDialogIfRequired(
//         context!,
//         envState!,
//         config.notifyUnderMaintenance,
//       );
//     }
//     if (appUpdate) {
//       await _showUpdateAppDialogIfRequired(
//         context!,
//         prefs!,
//         appForcedUpdate: config.appForcedUpdate,
//         appOptionalUpdate: config.appOptionalUpdate,
//       );
//     }
//     if (newTermsOfService) {
//       await _showNewTermsDialogIfRequired(
//         context!,
//         envState!,
//         prefs!,
//         config.notifyNewTermsOfService!,
//       );
//     }
//   }

//   static Future<bool> requiredShowingNewTerms({
//     SharedPreferencesClient? prefs,
//     EnvState? envState,
//     DateTime? tosAgreedAt,
//     NotifyNewTermsOfService? notifyNewTermsOfService,
//   }) async {
//     if (tosAgreedAt == null) {
//       // If the user hasn't yet agreed, show ToS.
//       return true;
//     }

//     final updatedAt = await getTosUpdatedAt(envState, notifyNewTermsOfService);
//     if (updatedAt == null) {
//       return false;
//     }

//     return updatedAt.isAfter(tosAgreedAt);
//   }

//   static Future<DateTime>? getTosUpdatedAt(
//     EnvState? envState,
//     NotifyNewTermsOfService? notifyNewTermsOfService,
//   ) async {
//     if (notifyNewTermsOfService != null) {
//       return notifyNewTermsOfService.updatedAt!;
//     }
//     return (await _fetch(envState))!.notifyNewTermsOfService!.updatedAt!;
//   }

//   static Future<RemoteConfigState>? _fetch(EnvState? envState) async {
//     final response =
//         await http.get(Uri.parse('${envState!.baseUrlS3}/config/owner.json'));
//     if (response.statusCode != 200) {
//       debugPrint('statusCode: ${response.statusCode}');
//       debugPrint('body: ${response.body}');
//       throw Exception();
//     }

//     final responseString = utf8.decode(response.bodyBytes);
//     return RemoteConfigState.fromJson(
//         jsonDecode(responseString) as Map<String, dynamic>);
//   }

//   // システムメンテンス
//   static Future<void> _showMaintenanceDialogIfRequired(
//     BuildContext context,
//     EnvState envState,
//     NotifyUnderMaintenance? notifyUnderMaintenance,
//   ) async {
//     if (notifyUnderMaintenance == null) {
//       return;
//     }
//     if (!notifyUnderMaintenance.active!) {
//       return;
//     }
//     final dialogConfig = notifyUnderMaintenance.dialog!.ja;
//     await _showOneButtonDialog(
//       context: context,
//       title: dialogConfig!.title,
//       message: dialogConfig.message,
//       actionOk: dialogConfig.actionRetry,
//       onButtonPressed: () => Navigator.of(context).pop(),
//     );

//     // refresh
//     final refreshedConfig = await _fetch(envState);
//     await _showMaintenanceDialogIfRequired(
//       context,
//       envState,
//       refreshedConfig!.notifyUnderMaintenance,
//     );
//   }

//   // アプリバージョンアップ
//   static Future<void> _showUpdateAppDialogIfRequired(
//     BuildContext context,
//     SharedPreferencesClient prefs, {
//     AppUpdate? appForcedUpdate,
//     AppUpdate? appOptionalUpdate,
//   }) async {
//     if (await _isShowForceUpdateDialog(appForcedUpdate)) {
//       await _showForceUpdateDialog(appForcedUpdate!, context);
//       return;
//     }

//     if (await _isShowOptionalUpdateDialog(appOptionalUpdate, prefs)) {
//       await _showOptionalUpdateDialog(appOptionalUpdate!, context);
//       final version = Platform.isIOS
//           ? appOptionalUpdate.ios!.version
//           : appOptionalUpdate.android!.version;
//       await prefs.saveLastOptionalVersionSuggested(version!);
//     }
//   }

//   static Future<bool> _isShowForceUpdateDialog(
//       AppUpdate? appForcedUpdate) async {
//     if (appForcedUpdate == null) {
//       return false;
//     }
//     final config =
//         Platform.isIOS ? appForcedUpdate.ios : appForcedUpdate.android;
//     if (config == null) {
//       return false;
//     }

//     final currentVersion = await _getAppVersion();
//     return currentVersion < Version.parse(config.version);
//   }

//   static Future<bool> _isShowOptionalUpdateDialog(
//     AppUpdate? appOptionalUpdate,
//     SharedPreferencesClient prefs,
//   ) async {
//     if (appOptionalUpdate == null) {
//       return false;
//     }
//     final config =
//         Platform.isIOS ? appOptionalUpdate.ios : appOptionalUpdate.android;
//     if (config == null) {
//       return false;
//     }

//     final lastOptionalVersionSuggested =
//         await prefs.loadLastOptionalVersionSuggested();
//     if (lastOptionalVersionSuggested == config.version) {
//       return false;
//     }

//     final currentVersion = await _getAppVersion();
//     return currentVersion < Version.parse(config.version);
//   }

//   static Future<void> _showForceUpdateDialog(
//     AppUpdate appUpdate,
//     BuildContext context,
//   ) async {
//     final dialogs = Platform.isIOS ? appUpdate.ios : appUpdate.android;
//     await _showOneButtonDialog(
//       context: context,
//       title: dialogs!.dialog!.ja!.title,
//       message: dialogs.dialog!.ja!.message,
//       actionOk: dialogs.dialog!.ja!.actionUpdate,
//       onButtonPressed: AppLinkOpener.showMarketStore,
//       barrierDismissible: false,
//     );
//   }

//   static Future<void> _showOptionalUpdateDialog(
//     AppUpdate appUpdate,
//     BuildContext context,
//   ) async {
//     final dialogs = Platform.isIOS ? appUpdate.ios : appUpdate.android;
//     final confirm = await _showTwoButtonsDialog(
//       context: context,
//       title: dialogs!.dialog!.ja!.title,
//       message: dialogs.dialog!.ja!.message,
//       actionOk: dialogs.dialog!.ja!.actionUpdate,
//       actionCancel: dialogs.dialog!.ja!.actionCancel,
//     );
//     if (!confirm) {
//       return;
//     }
//     await AppLinkOpener.showMarketStore();
//   }

//   // 利用規約再認証
//   static Future<void> _showNewTermsDialogIfRequired(
//     BuildContext context,
//     EnvState envState,
//     SharedPreferencesClient prefs,
//     NotifyNewTermsOfService notifyNewTermsOfService,
//   ) async {
//     final appUser = await prefs.loadAppUser();
//     final appUserMap = await prefs.loadAppUserMap();
//     final tosAgreedAt = appUser.lastTosAgreedAt == null
//         ? DateTime.parse(appUserMap.values.first.lastTosAgreedAt!)
//         : DateTime.parse(appUser.lastTosAgreedAt!);
//     if (!(await requiredShowingNewTerms(
//       prefs: prefs,
//       envState: envState,
//       tosAgreedAt: tosAgreedAt,
//       notifyNewTermsOfService: notifyNewTermsOfService,
//     ))) {
//       return;
//     }

//     await _showOneButtonDialog(
//       context: context,
//       title: notifyNewTermsOfService.dialog!.ja!.title,
//       message: notifyNewTermsOfService.dialog!.ja!.message,
//       actionOk: notifyNewTermsOfService.dialog!.ja!.actionAgree,
//       onButtonPressed: () => Navigator.of(context).pop(),
//       barrierDismissible: false,
//     );

//     // final arguments = TermsOfServiceScreenArguments(
//     //   tosUpdatedAt: notifyNewTermsOfService.updatedAt,
//     // );
//     // await Navigator.of(context, rootNavigator: true)
//     //     .pushNamed(TermsOfServiceScreen.routeName, arguments: arguments);
//     // await prefs.setLastTosAgreedAt(
//     //     lastTosAgreedAt: notifyNewTermsOfService.updatedAt);
//   }

//   static Future<Version> _getAppVersion() async {
//     final packageInfo = await PackageInfo.fromPlatform();
//     return Version.parse(packageInfo.version);
//   }

//   static Future<bool> _showTwoButtonsDialog({
//     BuildContext? context,
//     String? title,
//     String? message,
//     String? actionOk,
//     String? actionCancel,
//     bool barrierDismissible = true,
//   }) async {
//     final dialogResult = await showDialog<bool>(
//       context: context!,
//       barrierDismissible: barrierDismissible,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title!),
//           content: Text(message!),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(false),
//               child: Text(actionCancel ?? ''),
//             ),
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(true),
//               child: Text(actionOk ?? ''),
//             ),
//           ],
//         );
//       },
//     );
//     return dialogResult ?? false;
//   }

//   static Future<void> _showOneButtonDialog({
//     BuildContext? context,
//     String? title,
//     String? message,
//     String? actionOk,
//     VoidCallback? onButtonPressed,
//     bool barrierDismissible = true,
//   }) {
//     return showDialog<void>(
//       context: context!,
//       barrierDismissible: barrierDismissible,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title!),
//           content: Text(message!),
//           actions: <Widget>[
//             TextButton(
//               onPressed: onButtonPressed,
//               child: Text(actionOk!),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
