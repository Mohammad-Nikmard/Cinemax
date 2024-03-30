import 'package:cinemax/util/app_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {}

class FirebaseService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then((value) => null);
    FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();

    AppManager.setDeviceToken(fcmToken ?? "");

    FirebaseMessaging.onBackgroundMessage(
        (message) => handleBackgroundMessage(message));
  }
}
