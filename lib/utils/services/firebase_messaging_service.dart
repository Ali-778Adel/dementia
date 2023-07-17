import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../di/dependency-injection.dart';



///subscribe to firebase messaging
void subscribeToMessages() {
  // The following handler is called, when App is in the background.
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // The following function is not called, when a message was received by the device.
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('message from background handler');
  print("Handling a background message: ${message.messageId}");
}


class FirebaseMessagingService {

  Future pushNotificationToSpecificUser(
      {
       required String token,
      required String title,
      required String body}) async {
    var message = {
      'notification': {'title': title, 'body': body},
      'token': token
    };

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await sl<FirebaseAuth>().currentUser!.getIdToken()}'
    };
    var response = await http.post(
      Uri.parse(
          'https://fcm.googleapis.com/v1/projects/myprojectid/messages:send'),
      headers: headers,
      body: json.encode(message),
    );

    return response;
  }
}
