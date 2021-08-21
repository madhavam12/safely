import 'package:firebase_messaging/firebase_messaging.dart';

class FireMessage {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<String> get deviceToken => messaging.getToken();

  void initialize() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
