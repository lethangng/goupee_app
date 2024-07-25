// import 'dart:convert';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';

// import '../../app/routes.dart';

// class FirebaseApi {
//   final _firebaseMessaging = FirebaseMessaging.instance;

//   final _androidChannel = const AndroidNotificationChannel(
//     'high_importtance_channel',
//     'High Importance Notification',
//     description: 'This channel is used for important notification',
//     importance: Importance.defaultImportance,
//   );
//   final _localNotifications = FlutterLocalNotificationsPlugin();

//   Future<void> handleBackgroundMessage(RemoteMessage message) async {
//     debugPrint('Title: ${message.notification?.title}');
//     debugPrint('Body: ${message.notification?.body}');
//     debugPrint('Payload: ${message.data}');
//   }

//   void handleMessage(RemoteMessage? message) {
//     if (message == null) return;
//     Get.toNamed(Routes.signup);
//   }

//   Future initPushNotifications() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     FirebaseMessaging.instance.getInitialMessage().then(
//           (message) => handleMessage(message),
//         );

//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       // print('${message.data}');
//       handleMessage(message);
//     });

//     // FirebaseMessaging.onBackgroundMessage(
//     //   (message) => handleBackgroundMessage(message),
//     // );

//     FirebaseMessaging.onMessage.listen((message) {
//       final notification = message.notification;
//       if (notification == null) return;
//       _localNotifications.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             _androidChannel.id,
//             _androidChannel.name,
//             channelDescription: _androidChannel.description,
//             icon: '@drawable/ic_launcher',
//           ),
//         ),
//         payload: jsonEncode(message.toMap()),
//       );
//     });
//   }

//   Future initLocalNotifications() async {
//     const iOS = DarwinInitializationSettings();
//     const android = AndroidInitializationSettings('@drawable/ic_launcher');
//     const setting = InitializationSettings(android: android, iOS: iOS);

//     await _localNotifications.initialize(setting);

//     final platform = _localNotifications.resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>();
//     await platform?.createNotificationChannel(_androidChannel);
//   }

//   Future<void> initNotifications() async {
//     await _firebaseMessaging.requestPermission();
//     final fcmToken = await _firebaseMessaging.getToken();
//     debugPrint('Token: $fcmToken');
//     initLocalNotifications();
//     initPushNotifications();
//   }
// }
