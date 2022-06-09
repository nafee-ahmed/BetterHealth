import 'dart:convert';
import 'dart:math';

import 'package:better_health/utils/custom_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class MessagingService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() {
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _notificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? id) async {
      print('on select notification messaging service');
      if (id!.isNotEmpty) {
        print(id);
        // if (id == 'notification') 
      }
    });
  }

  static void display(RemoteMessage message) async{
    try {
      Random random = new Random();
      int id = random.nextInt(1000);
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "mychanel",
            "my chanel",
            importance: Importance.max,
            priority: Priority.high,
          )

      );
      print("my id is ${id.toString()}");
      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: 'notification'
      );
    } on Exception catch (e) {
      print('Error>>>$e');
    }
  }

  static Future storeNotificationToken() async {
    try {
      final user = await FirebaseAuth.instance.currentUser;
      String? token = await FirebaseMessaging.instance.getToken();
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'token': token
      }, SetOptions(merge: true));
    } on FirebaseAuthException catch (e) {
      print(e);
      throw CustomException(e.message);
    }
  }

  static Future sendNotification(String title, String body, String token) async {
    final data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'message': title
    };

    try {
      http.Response response = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'), headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=AAAAkPt8WWg:APA91bEDMOeJM65AHJtwCIWJDQVLgHXGaTOaX1O6DZkYR9lHKvRmAGKw2s8mH7a18ENVxdr136gXYd8E4FI7Gf8t6stc6CZGa6EyVXG2bMlCx46g2hxLEJp_UvH-m7E0B8scy2_4TLGB',
      },
      body: jsonEncode(<String, dynamic>{
        'notification': <String, dynamic>{'title': title, 'body': body},
        'priority': 'high',
        'data': data,
        'to': '$token'
      })
      );

      if(response.statusCode == 200) {
        print('notification sent');
      } else {
        print('error');
      }
    } catch (e) {
      print(e);
    }
  }

  static Stream<QuerySnapshot> loadNotifications() async* {
    try {
      final user = await FirebaseAuth.instance.currentUser;
      yield* FirebaseFirestore.instance.collection('notifications').where('receiverID', isEqualTo: user!.uid).snapshots();
    } on FirebaseAuthException catch (e) {
      print(e.stackTrace);
      throw CustomException(e.message);
    }
  }

  static NotificationInit() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print('notification received from terminated state');
      if(message != null) MessagingService.display(message);
    });  // this method calls when app in terminated state.

    FirebaseMessaging.onMessage.listen((event) {  // foreground state
      MessagingService.display(event);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) { // background state
      print('background message');
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print(message.data['id']);
        MessagingService.display(message);
      }
    });
  }

}
