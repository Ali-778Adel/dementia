import 'package:flutter/material.dart';
import 'package:time_control/presentation/pages/auth/add_phone_number_screen.dart';
import 'package:time_control/presentation/pages/auth/login_page.dart';
import 'package:time_control/presentation/pages/home/home-screen.dart';
import 'package:time_control/presentation/pages/settings/profile_page.dart';
import 'package:time_control/presentation/pages/settings/settings_page.dart';

/// main launch routes
///**this method control top level navigation
///

class AppRoutes{
  static GlobalKey<NavigatorState> mainNavigator = GlobalKey();
  static GlobalKey<NavigatorState> settingsNavigator = GlobalKey();

 static Route<dynamic>?mainCycleNavigator(RouteSettings settings){
    if(settings.name=='/'){
      return MaterialPageRoute(builder: (context)=>const LoginPage());
    }else if(settings.name=='homePage') {
      return MaterialPageRoute(builder: (context)=>const HomeScreen());
    }else if(settings.name=='phonePage'){
      return MaterialPageRoute(builder: (context)=> AddPhoneNumberScreen());
    }
    return null;


  }

 static Route<dynamic>?settingsCycleRoutes(RouteSettings settings){
    if(settings.name=='/'){
      return MaterialPageRoute(builder: (context)=> SettingsScreen());
    }else if(settings.name=='profileScreen') {
      return MaterialPageRoute(builder: (context)=>const ProfileScreen());
    }
    return null;


  }
}

