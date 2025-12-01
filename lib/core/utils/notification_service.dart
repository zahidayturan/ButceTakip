import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

/*
LocalNotificationService localNotificationService = LocalNotificationService();
*/
class FirebaseNotificationService {
  late final FirebaseMessaging firebaseMessaging;

  void settingNotification() async{
    await firebaseMessaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
    );
  }

  Future<void> connectNotification(BuildContext context) async {
    firebaseMessaging = FirebaseMessaging.instance;

    firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );

    settingNotification();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //final snackBar = SnackBar(content: Text("${message.notification?.title?? "boş"}\n${message.notification?.body?? "boş"}"));
      //ScaffoldMessenger.of(context).showSnackBar(snackBar);

      //localNotificationService.showNotification(
      //    title: message.notification?.title?? "boş",
      //    body: message.notification?.body?? "boş"
      //);
    });/// uygulama arayüzdeyken bildirim gelmesi için

  }

  @pragma('vm:entry-point')
  static Future<void> backgroundMessage(RemoteMessage message) async{

    //localNotificationService.showNotification(
    //    title: message.notification?.title?? "boş",
    //    body: message.notification?.body?? "boş"
    //);
    ///Bunu kapatma nedeni fcm nin kendi sunduğu vaysayılan bildirim var ve o deaktif edilemiyor.
  }///Bildirimin arka planda çalışması için

  Future<bool> contolNotification() async {
    firebaseMessaging = FirebaseMessaging.instance;
    NotificationSettings settings = await firebaseMessaging.requestPermission(announcement: true);
    return (settings.authorizationStatus == AuthorizationStatus.authorized);
  }
}
/*
class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async{
    AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('ikon_bka_2');

    InitializationSettings initializationSettings =
    InitializationSettings(
      android: androidInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  } /// Bildirimlerin başlatmak içindir

  Future notificationDetails() async{
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        icon: 'ikon_bka_2',
        subText: "Yeni Bildirim",
        channelShowBadge: true,
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  } /// Bildirimlerin görümünü ayarlamaktadır

  Future showNotification({int id = 0, String? title, String? body, String? payload}) async{
    return flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      payload: payload,
      await notificationDetails(),
    );
  } /// Bildirimleri göstermektedir
}
*/

