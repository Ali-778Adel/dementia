// ignore_for_file: file_names

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:time_control/presentation/resources/routes.dart';
import '../../../di/dependency-injection.dart';
import '../../global_widgets/bottom_nav_bar.dart';
import '../settings/settings_navigator_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}
var val=List.generate(6, (index) => false);
class _HomeScreen extends State<HomeScreen> {
  var currentIndex = 0;
  var pages = [
    const FirstPage(),
    const SettingsMainPage()];

  @override
  Widget build(BuildContext context) {

    debugPrint('${getToken()}');
    debugPrint('home build is rebuilt');
    return WillPopScope(
      onWillPop: ()async {
        switch(currentIndex){
          case 1:{
            return !await AppRoutes.settingsNavigator.currentState!.maybePop();
          }
          default:{
            return Future.value(false);
          }
        }
      },
      child: Scaffold(
          body: _buildBody(context),
          bottomNavigationBar: CurvedBottomNavBar(
                  onTap: (index) => setState(() => currentIndex = index),
                  currentIndex: currentIndex)
              .call()),
    );
  }

  Widget _buildBody(BuildContext context) {
    return pages[currentIndex];
  }

  Future<String?>getToken()async{
  sl<FirebaseMessaging>().getToken().then((newToken) {
    debugPrint('$newToken');
    
  });
  return null;
  }
}
class FirstPage extends StatelessWidget{
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Table(
          border: TableBorder(verticalInside: BorderSide(color: Colors.black)),
          // columnWidths: {2  ,MediaQuery.of(context).size.width*.50},
          children: [
            TableRow(
              children: [
                Text('dose'),
                Text('qry'),
              ]
            ),
            TableRow(
              children: [
                Row(children: [
                  Text('item1'),
                  Checkbox(value: true, onChanged: (val){})
                ],),
                Text('data')
              ]
            ),

          ],
        ),
      )
    );
  }
  Future<void> _showNotificationWithActions() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      actions: [
        AndroidNotificationAction('id', 'title')
      ]

    );
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
     FlutterLocalNotificationsPlugin().show(
        0, 'plain title', 'plain body', notificationDetails,
        payload: 'item x');
  }
}