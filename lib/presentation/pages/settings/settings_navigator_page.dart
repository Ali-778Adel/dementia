import 'package:flutter/material.dart';

import '../../resources/routes.dart';

class SettingsMainPage extends StatelessWidget {
  const SettingsMainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return  Navigator(
      key: AppRoutes.settingsNavigator,
      initialRoute: '/',
      onGenerateRoute:AppRoutes.settingsCycleRoutes,
    );
  }
}
