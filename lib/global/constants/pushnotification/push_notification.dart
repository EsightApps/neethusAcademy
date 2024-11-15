import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';





class PushNotificationService {
  FirebaseMessaging fcm = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Initialize Firebase
    await Firebase.initializeApp();

    // Local notification initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    // Initialize flutter_local_notifications with a callback for notification taps
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        // This is triggered when the notification is tapped.
        String? payload = details.payload;  // Get the payload (URL) from the notification
        onSelectNotification(payload);
      },
    );

    // Firebase Messaging listeners
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
        _showNotification(
          message.notification!.title ?? 'Title',
          message.notification!.body ?? 'Body',
        message.notification!.body ?? 'Body',
        );
      }
    });

    // Ensure background message handler is registered
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Optionally retrieve the token
    await getToken();
  }

  Future<String?> getToken() async {
    String? token = await fcm.getToken();
    log('Token: $token');
    return token;
  }

  // Background message handler should be static or top-level function
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();  // Ensure Firebase is initialized
    log('Handling a background message: ${message.messageId}');
    // Handle background notifications here if needed
  }

  // Show notification with URL
  Future<void> _showNotification(String title, String body, String? url) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel', // Channel ID
      'High Importance Notifications', // Channel name
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Pass the URL as payload so it can be opened later when the notification is tapped
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      platformChannelSpecifics,
      payload: url, // Pass the URL as the payload
    );
  }

  // Handle notification tap and open URL
  Future<void> onSelectNotification(String? payload) async {
    if (payload != null) {
      log('Notification tapped! Opening URL: $payload');
  
      // Use url_launcher to open the URL
      if (await canLaunchUrl(Uri.parse(
        payload))) {
        await launchUrl(Uri.parse(payload)); // Open the URL
      } else {
        log(payload);
        log('Could not launch the URL');
      }
    }
  }
}
