import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/api_manager/api_service.dart';
import '../core/app/app_widget.dart';
import '../core/util/shared_preferences.dart';
import '../features/notification/bloc/notification_count_cubit/notification_count_cubit.dart';
import '../firebase_options.dart';
import '../main.dart';

class FirebaseService {
  static Future<void> initial() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    getFireTokenAsync();
    requestPermission();
    setListener();
  }

  static void setListener() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.onTokenRefresh.listen((event) {});

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      String title = '';
      String body = '';

      if (notification != null) {
        title = notification.title ?? '';
        body = notification.body ?? '';
      } else {
        title = message.data['title'] ?? '';
        body = message.data['body'] ?? '';
      }

      Note.showBigTextNotification(title: title, body: body);

      if (AppSharedPreference.getNotificationState) {
        Note.showBigTextNotification(title: title, body: body);
      }

      AppSharedPreference.addNotificationCount();

      ctx?.read<NotificationCountCubit>().changeCount();
    });
  }

  static String get getFireTokenFromCache {
    final cashedToken = AppSharedPreference.getFireToken;

    if (cashedToken.isNotEmpty) return cashedToken;

    loggerObject.e('FCM Token Empty');

    throw Exception('FCM Token Empty');
  }

  static Future<String> getFireTokenAsync({bool reNew = false}) async {
    try {
      final cashedToken = AppSharedPreference.getFireToken;

      if (cashedToken.isNotEmpty) return cashedToken;

      final token = await FirebaseMessaging.instance.getToken();

      if (token != null) AppSharedPreference.cashFireToken(token);

      return token ?? '';
    } catch (e) {
      loggerObject.e(e);
      return e.toString();
    }
  }

  static Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (!AppSharedPreference.isInitial) {
    await SharedPreferences.getInstance().then((value) => AppSharedPreference.init(value));
  }

  final notification = message.notification;

  String title = '';
  String body = '';

  if (notification != null) {
    title = notification.title ?? '';
    body = notification.body ?? '';
  } else {
    title = message.data['title'] ?? '';
    body = message.data['body'] ?? '';
  }

  if (AppSharedPreference.getNotificationState) {
    Note.showBigTextNotification(title: title, body: body);
  }
  AppSharedPreference.addNotificationCount();
}
