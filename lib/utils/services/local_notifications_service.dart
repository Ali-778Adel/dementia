import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService1 {

  /// instance of local_notification_plugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

   Future initLocalNotifications() async {

    /// init android settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    /// init ios settings
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestAlertPermission: true,
            requestBadgePermission: true,
            requestCriticalPermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: ( int? id, String? title, String? body, String? payload)async{});

    ///init android and ios params
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    /// init local_notification_plugin
    await flutterLocalNotificationsPlugin
        .initialize(initializationSettings,
            onDidReceiveNotificationResponse: onDidReceiveNotificationResponse)
        .then((value) async {
          debugPrint('hello here .... local_notifications initializations = $value');
    });
  }

  /// handle tap on notifications events
  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    } else {
      debugPrint('all is done ');
    }
  }


  Future _showNotificationNow()async{
    await flutterLocalNotificationsPlugin.show(
        1,
        'title',
        'body',
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description',
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker',
                actions: [AndroidNotificationAction('id', 'title')]),
            iOS: DarwinNotificationDetails()
        ));
  }

}



class  LocalNotificationService{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future initNotifications()async{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@drawable/notebook');
  final DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
    onDidReceiveLocalNotification:  ( int? id, String? title, String? body, String? payload)async{}
  );
  final LinuxInitializationSettings initializationSettingsLinux =
  LinuxInitializationSettings(
      defaultActionName: 'Open notification');
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (r){
    if(r.payload!=null){
      debugPrint('pay load is null');
    }else{
      debugPrint( 'MESSAGE FROM NOTIFICATIONS  ${r.actionId}');
    }
      });
}


Future showNoti()async{

  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('your channel id', 'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker');
  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  try{
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', notificationDetails,
        payload: 'item x');
  }catch(e,s){
    debugPrint('the stacktrace erro occured during showing the notifications is $s  ');
  }
}
}