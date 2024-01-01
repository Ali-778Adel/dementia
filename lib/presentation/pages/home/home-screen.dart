// ignore_for_file: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shake/shake.dart';
import 'package:sizer/sizer.dart';
import 'package:time_control/core/localization/strings.dart';
import 'package:time_control/presentation/resources/palette.dart';
import 'package:time_control/presentation/resources/routes.dart';
import '../../../di/dependency-injection.dart';
import '../../global_widgets/bottom_nav_bar.dart';
import '../settings/settings_navigator_page.dart';

class MainRouteScreen extends StatefulWidget {
  const MainRouteScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}
var val=List.generate(6, (index) => false);
class _HomeScreen extends State<MainRouteScreen> {
  ShakeDetector ?detector;
  var currentIndex = 0;
  var pages = [
    const HomeScreen(),
    const Scaffold(),
    const Scaffold(),
    const SettingsMainPage()];

  @override
  void initState() {
    // TODO: implement initState

    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Shake!'),
          ),
        );
        // Do stuff on phone shake
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
    super.initState();
  }
  @override
  void dispose(){
    detector!.stopListening();
   super.dispose();
  }

  @override
  Widget build(BuildContext context){

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
            context: context,
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
class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body:SingleChildScrollView(
        padding: EdgeInsets.only(top: 8.sp,bottom:32.sp,right:8.sp,left: 8.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(items: List.generate(5, (index) => 
                Container(

                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.015,vertical: 8.sp),
                  width: MediaQuery.of(context).size.width/.90,
                  // width: MediaQuery.of(context).size.width/.80,
                  decoration: BoxDecoration(
                    color: Palette.green,
                    borderRadius:BorderRadius.all(Radius.circular(12.sp)),
                    boxShadow:const [
                      BoxShadow(
                        color:Palette.lightGreen,
                        spreadRadius: 0.4,
                        blurRadius: 0.1,
                        offset: Offset(0.0,12)
                      ),

                    ]
                  ),
              padding:  EdgeInsets.all(8.sp),
                  child: Image.asset('assets/photos/petrol.png',fit: BoxFit.fill,),
            )),
                options:CarouselOptions(
                  clipBehavior: Clip.hardEdge,
                  autoPlayCurve: Curves.easeOut,
                  enlargeCenterPage: true,
                  aspectRatio: 1/3,
                    autoPlay: true,
                    height: MediaQuery.of(context).size.height*.25)),
            Padding(padding: const EdgeInsets.symmetric(vertical: 12)
            ,child: Text(Strings.of(context)!.shake,style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontFamily: 'Poppins-Black.ttf',
                fontSize: 24,
                height: .999
              ),),
            ),
/// map
            Container(
              width: MediaQuery.of(context).size.width/.85,
              height: 140.sp,
              decoration: BoxDecoration(
                  color: Palette.green,
                  borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Palette.black10)
              )
            ),
            Padding(padding:  EdgeInsets.symmetric(vertical: 0.sp),
              child: Text('خدمات',style:Theme.of(context).textTheme.headlineLarge,),
            ),

            SizedBox(
              height: 80.sp,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(10, (index) => Container(
                  height: 80.sp,
                  width: 80.sp,
                  margin:const  EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Palette.green,
                    borderRadius:BorderRadius.circular(12),
                    border: Border.all(color: Palette.black10),
                  ),
                )),
              ),
            ),

            Padding(padding:  EdgeInsets.symmetric(vertical: 0.sp),
              child: Text('اضغط واستلم',style:Theme.of(context).textTheme.headlineLarge,),
            ),

            CarouselSlider(
                items: List.generate(5, (index) =>
                Container(
                  height: 80.sp,
                  width: 80.sp,
                  margin:const  EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Palette.green,
                    borderRadius:BorderRadius.circular(12),
                    border: Border.all(color: Palette.black10),
                  ),
                )
            ),
                options:CarouselOptions(
                  viewportFraction: .3,
                    autoPlayCurve: Curves.easeOut,
                    enlargeCenterPage: false,
                    autoPlay: true,
                    // autoPlayAnimationDuration: Duration(seconds: 10),
                    height:80.sp)),

        ],


        ),
      ),

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