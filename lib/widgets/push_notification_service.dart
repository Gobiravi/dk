import 'dart:io';
import 'package:dikla_spirit/custom/secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class PushNotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize(BuildContext context) async {
    await Firebase.initializeApp();
    // Request permissions on iOS
    if (Platform.isIOS) {
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        print('🔒 Notification permission denied');
        return;
      }
    }

    // Initialize local notifications (for foreground)
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const initSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);
    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (payload) {
        // Handle payload if needed
      },
    );

    // Show token
    final token = await _firebaseMessaging.getToken();
    debugPrint("FCM Token: $token");
    SecureStorage.save("fcmToken", token ?? "");
    // Listen to foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 Got a message while in the foreground!");

      if (message.notification != null) {
        print("🔔 Notification Title: ${message.notification!.title}");
        print("📝 Notification Body: ${message.notification!.body}");
      }

      if (message.data.isNotEmpty) {
        print("📦 Data: ${message.data}");
      }
      _showNotification(message);
    });

    // App opened from background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessageClick(context, message);
    });

    // App opened from terminated state
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageClick(context, initialMessage);
    }
  }

  static Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      message.notification.hashCode,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
    );
  }

  static void _handleMessageClick(BuildContext context, RemoteMessage message) {
    // Custom logic to handle the message tap
    debugPrint("Notification tapped: ${message.data}");
    // You can use `message.data` to navigate or update state
  }
}
