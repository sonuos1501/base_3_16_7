// // ignore_for_file: use_build_context_synchronously, lines_longer_than_80_chars

// import 'dart:developer';
// import 'dart:io';

// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import '../../constants/colors.dart';
// import '../custom_log/custom_log.dart';

// // It must not be an anonymous function.
// // It must be a top-level function.
// // see https://firebase.flutter.dev/docs/messaging/usage#background-messages
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   log('Handling a background message: ${message.data}');
//   // for example handle update badge for android
//   NotificationUtil._updateBadgeCount(message);
// }

// // To show data message type in background mode
// // On Android, set the priority field to high.
// // On Apple (iOS & macOS), set the content-available field to true.
// // Note: this still does not guarantee delivery.
// // see https://firebase.flutter.dev/docs/messaging/usage#message-types
// // and firebase.flutter.dev/docs/messaging/usage#low-priority-messages

// // TODO(anyone): integrate firebase with APNs apple
// // see: https://firebase.flutter.dev/docs/messaging/apple-integration/

// class NotificationUtil {
//   NotificationUtil._();

//   static const channelId = 'channelId';
//   static const channelName = 'channelName';
//   static const localNotifyID = 0;
//   static final messaging = FirebaseMessaging.instance;

//   // Initalize the [FlutterLocalNotificationsPlugin] package.
//   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static void notificationTapBackground(
//     NotificationResponse notificationResponse,
//   ) {
//     // ignore: avoid_print
//     print(
//       'notification(${notificationResponse.id}) action tapped: '
//       '${notificationResponse.actionId} with'
//       ' payload: ${notificationResponse.payload}',
//     );
//     if (notificationResponse.input?.isNotEmpty ?? false) {
//       // ignore: avoid_print
//       print(
//         'notification action tapped with input: ${notificationResponse.input}',
//       );
//     }
//   }

//   static Future<void> initialize(BuildContext context) async {
//     final token = await messaging.getToken();
//     logToken('Notification token: $token');
//     final initialMsg = await messaging.getInitialMessage();

//     if (initialMsg != null) {
//       await _showScreensByMessage(context, initialMsg);
//     }
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//     await _onMessage(context);

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       _showScreensByMessage(context, message, onLaunch: true);
//     });

//     await _initializeLocalNotification(context);
//   }

//   static void handleOnDidReceiveBackgroundNotificationResponse(
//     NotificationResponse notificationResponse,
//   ) {
//     //  //navigate when tap noti bar (app in foreround mode)
//     // try {
//     //   // final payload =
//     //   //     jsonDecode(payloadString) as Map<String, dynamic>; //todo action when tap noti
//     //   // await _showScreens(context, payload);
//     //   print('object');
//     // } on Exception catch (e, trace) {
//     //   await FirebaseCrashlytics.instance.recordError(e, trace);
//     // }

//     // return;
//   }
//   //create channel noti in local when app in background mode, will show noti bar
//   // need exactly channel setting on firebase
//   static Future<void> _initializeLocalNotification(BuildContext context) async {
//     // initialise the plugin. ic_notification needs to be a added as a drawable resource to the Android head project
//     // see more: https://developer.android.com/studio/write/image-asset-studio#create-notification
//     const settingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true, // Required to display a heads up notification
//       badge: true,
//       sound: true,
//     );

//     // if you want to request permissions at a later point in your application on iOS,
//     // set the first 3 properties to false
//     // then call the requestPermissions method with desired permissions
//     // at the appropriate point in your application
//     // see https://pub.dev/packages/flutter_local_notifications#ios-all-supported-versions-and-macos-1014-requesting-notification-permissions
//     final initializationSettingsDarwin = DarwinInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//       onDidReceiveLocalNotification: (id, title, body, payload) =>
//           {debugPrint('object')},
//     );

//     final initializationSettings = InitializationSettings(
//       android: settingsAndroid,
//       iOS: initializationSettingsDarwin, //todo ios initial setting
//     );

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveBackgroundNotificationResponse:
//           handleOnDidReceiveBackgroundNotificationResponse, //todo:
//       onDidReceiveNotificationResponse: notificationTapBackground, //todo:
//     );
//   }

//   // only for ios/ mac os
//   static Future<void> requestPermissions() async {
//     if (Platform.isAndroid) {
//       return;
//     }
//     final settings = await FirebaseMessaging.instance.requestPermission();

//     log('User granted permission: ${settings.authorizationStatus}');
//   }

//   static Future<void> _onMessage(BuildContext context) async {
//     const channel = AndroidNotificationChannel(
//       channelId, // id
//       channelName, // title
//       description:
//           'This channel is used for important notifications.', // description
//       importance: Importance.max, // Required to display a heads up notification
//       ledColor: AppColors.alertColor,
//     );

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);

//     // handle when has new notification
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       final notification = message.notification;
//       final android = message.notification?.android;

//       if (notification != null && android != null) {
//         final platformChannelSpecifics = NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel.id,
//             channel.name,
//             channelDescription: channel.description,
//             importance: Importance.max,
//             icon: android.smallIcon,
//             priority: Priority.high,
//             color: channel.ledColor,
//             colorized: true,
//           ),
//           iOS: const DarwinNotificationDetails(),
//         );

//         // show local notification or head-up

//         await flutterLocalNotificationsPlugin.show(
//           localNotifyID,
//           notification.title,
//           notification.body,
//           platformChannelSpecifics,
//           payload: 'item z',
//         );

//         // handle something else for example update badge icon android
//         NotificationUtil._updateBadgeCount(message);
//       }
//     });
//   }

//   // you need update device token if use amazon SNS
//   // when platform endpoint is deactivated
//   static Future<void> updateFcmTokenIfRequired({
//     String? fcmToken,
//   }) async {
//     final newFcmToken = fcmToken ?? await messaging.getToken();
//     // final userInfo = await LocalStorage.loadUserInfo();
//     // final currentFcmToken = userInfo.fcmToken;

//     // if (newFcmToken == currentFcmToken) {
//     //   return;
//     // }

//     if (newFcmToken == null) {
//       return;
//     }

//     // call API update device token to amazone SNS
//   }

//   static Future<void> _showScreensByMessage(
//     BuildContext context,
//     RemoteMessage message, {
//     bool onLaunch = false,
//   }) async {
//     try {
//       final data = message.data;
//       await _showScreens(context, data, onLaunch: onLaunch);
//     } on Exception catch (e, trace) {
//       await FirebaseCrashlytics.instance.recordError(e, trace);
//     }
//   }

//   static Future<void> _showScreens(
//     BuildContext context,
//     Map<String, dynamic> payload, {
//     bool onLaunch = false,
//   }) async {
//     const topicKey = 'topic_id';
//     const noticeKey = 'topic_id';

//     if (payload.containsKey(topicKey)) {
//       final topicId = (payload[topicKey] ?? '').toString();

//       if (topicId.isEmpty) {
//         return;
//       }

//       // push to target screen

//       return;
//     }

//     // if need handle other case
//     if (payload.containsKey(noticeKey)) {
//       final noticeId = (payload[noticeKey] ?? '').toString();

//       if (noticeId.isEmpty) {
//         return;
//       }

//       // push to target screen

//       return;
//     }
//   }

//   static void _updateBadgeCount(RemoteMessage message) {
//     if (Platform.isIOS) {
//       // ios automatic update badge icon through APNs
//       // you need return
//       return;
//     }

//     final badgeStr = (message.data['badge'] ?? '').toString();
//     // ignore: unused_local_variable
//     final badgeCount = int.tryParse(badgeStr) ?? 0;

//     // update flutter app badge icon for this session by using badgeCount
//   }
// }
