// // ignore_for_file: avoid_print

// import 'package:firebase_analytics/firebase_analytics.dart';

// enum AnalyticsEventType {
//   appLaunched,
// }

// extension AnalyticsEventTypeExtension on AnalyticsEventType {
//   String get name {
//     var string = '';
//     switch (this) {
//       case AnalyticsEventType.appLaunched:
//         string = 'app_launched';
//         break;
//     }
//     return string;
//   }
// }

// class AnalyticsUtil {
//   AnalyticsUtil(this.analytics);

//   final FirebaseAnalytics analytics;

//   Future<void> logEvent(
//     AnalyticsEventType type, {
//     Map<String, dynamic>? parameters,
//   }) async {
//     try {
//       await analytics.logEvent(
//         name: type.name,
//         parameters: parameters,
//       );
//     } on Exception catch (e) {
//       print(e);
//     }
//   }

//   Future<void> logLogin({String? loginMethod}) {
//     return analytics.logLogin(loginMethod: loginMethod);
//   }

//   Future<void> setCurrentScreen({String? screenName}) {
//     return analytics.setCurrentScreen(screenName: screenName);
//   }
// }
