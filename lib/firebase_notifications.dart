import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';

class FirebaseNotifications {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
    playSound: true, // لازم تحطها هون
    sound: RawResourceAndroidNotificationSound('default'),
  );

  static Future<void> initNotifications() async {
    await Firebase.initializeApp();

    // طلب صلاحيات على iOS
    if (Platform.isIOS) {
      await _messaging.requestPermission(alert: true, badge: true, sound: true);
    }

    // إعداد الإشعارات المحلية
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    // إنشاء قناة الإشعارات للأندرويد
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
    // تهيئة الإشعارات المحلية
    await _flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );

    // معالجة الإشعارات داخل التطبيق
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        _flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              playSound: true, // شغّل الصوت
              sound: null,
              icon: android.smallIcon ?? '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });

    // معالجة الإشعارات في الخلفية
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // احصل على FCM Token
    String? token = await _messaging.getToken();
    print('==================FCM Token: $token');

    _messaging.onTokenRefresh.listen((newToken) async {
      print('Token updated: $newToken');
      // هنا ترسل التوكن الجديد للباكند
      //await sendTokenToBackend(newToken);
    });

    // دالة لإرسال إشعار محلي للاختبار

    // إذا جاهز endpoint backend، أرسله لهون:
    // await sendTokenToBackend(token);
  }

  //  static Future<void> sendTokenToBackend(String? token) async {
  //   if (token == null) return;

  //   const String endpoint = 'https://your-backend.com/api/save-fcm-token'; // استبدل بالرابط الحقيقي

  //   try {
  //     final response = await http.post(
  //       Uri.parse(endpoint),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'token': token}),
  //     );

  //     if (response.statusCode == 200) {
  //       print('Token sent to backend successfully');
  //     } else {
  //       print('Failed to send token. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error sending token to backend: $e');
  //   }
  // }
  static Future<void> showLocalNotification({
    String title = 'اختبار الإشعار',
    String body = 'تم إرسال إشعار محلي من الزر',
  }) async {
    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
          priority: Priority.high,
          playSound: true, // شغّل الصوت
          sound: null,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }

  // هندل الخلفية
  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp();
    print('📦 إشعار بالخلفية: ${message.notification?.title}');
  }
}
