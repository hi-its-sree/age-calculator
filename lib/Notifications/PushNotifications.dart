import 'package:firebase_messaging/firebase_messaging.dart';


Future<void>handleBackgroundMessaging(RemoteMessage message) async
{
  print('Title:${message.notification?.title}');
  print('Body:${message.notification?.body}');
  print('Payload:${message.data}');
}

class Notifications
{
  final firebaseMessaging=FirebaseMessaging.instance;
  Future<void>initNotifications() async{
    await firebaseMessaging.requestPermission();
    final fcmToken=await firebaseMessaging.getToken();
    print('fcmToken:$fcmToken ');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessaging);
  }
}