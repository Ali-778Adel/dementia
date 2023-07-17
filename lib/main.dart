import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:time_control/di/dependency-injection.dart';
import 'package:time_control/presentation/pages/auth/bloc/sign_in_bloc/auth_bloc.dart';
import 'package:time_control/presentation/pages/home/home-screen.dart';
import 'package:time_control/presentation/pages/settings/blocs/settings_main_bloc/settings_bloc.dart';
import 'package:time_control/presentation/pages/settings/blocs/settings_main_bloc/settings_states.dart';
import 'package:time_control/presentation/pages/ui_tutorial/neon_splash.dart';
import 'package:time_control/presentation/payment_third_screen.dart';
import 'package:time_control/presentation/resources/routes.dart';
import 'package:time_control/presentation/resources/styles.dart';
import 'package:time_control/utils/services/firebase_messaging_service.dart';
import 'package:time_control/utils/services/firebase_services.dart';
import 'package:time_control/utils/services/local_notifications_service.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';
import 'package:time_control/core/localization/strings.dart';

import 'data/data_sources/local_data_sources/pref_manger.dart';




inMessages(){
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification ?notification = message.notification;
    AndroidNotification ?android = message.notification?.android;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      sl<LocalNotificationService>().flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
        const  NotificationDetails(
            android: AndroidNotificationDetails(
              'channel_1',
              'channel_1',
              // other properties...
            ),
          ));
    }
  });
}

void main()  {
  ensureInitialization();
}

/// handle dependency initialization and top level methods
Future<void> ensureInitialization()async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  subscribeToMessages();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  initServiceLocator();
  inMessages();
  FlutterNativeSplash.remove();
  setSystemOverlay();
}

/// init service locator then launch MyApp() class then init local Notification
Future<void> initServiceLocator()async
{
  await serviceLocator();
  await sl<FirebaseService>().init().then((value) => runApp(const MyApp()));
  await sl<LocalNotificationService>().initNotifications().then((value)async {
    await  sl<LocalNotificationService>().showNoti().then((value)async {
      
    });
  });


}
///setup system overlay style
void setSystemOverlay() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
}


/// app root class
class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) =>sl<SettingsBloc>()),
          BlocProvider(create: (_)=>sl<AuthBloc>())

        ],
        child: Sizer(
          builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) {
            return BlocBuilder<SettingsBloc,SettingsStates>(
                builder: (context,state) {
                  return OKToast(
                      child: MaterialApp(
                        // navigatorKey: AppRoutes.mainNavigator,
                        // initialRoute:_getInitialRoute() ,
                        onGenerateRoute:AppRoutes.mainCycleNavigator,
                        debugShowCheckedModeBanner: false,
                        theme: themeLight,
                        darkTheme: themeDark,
                        themeMode:
                        sl<PrefManger>().theme=='light'?ThemeMode.light:
                        sl<PrefManger>().theme=='dark'?ThemeMode.dark:
                        ThemeMode.system,
                        locale: Locale(sl<PrefManger>().locale),
                        localizationsDelegates: const [
                          Strings.delegate, // Add this line
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                        ],
                        supportedLocales: const [Locale('ar'), Locale('en')],
                        home:  const NeonSplash(),

                      ));
                }
            );
          },
        ));
  }


  /// get the app initial route depending on cached user data in shared pref manger.
  String _getInitialRoute(){
    var userData=sl<PrefManger>().userCredentials;
    if(userData.isNotEmpty){
      return 'homePage';
    }else{
      return '/';
    }
  }
}
