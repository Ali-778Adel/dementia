import 'package:shared_preferences/shared_preferences.dart';

enum ActiveTheme {
  light("light"),
  dark("dark"),
  system("system");

  final String description;

  const ActiveTheme(this.description);
}

class PrefManger {
  final SharedPreferences sharedPreferences;
  PrefManger(this.sharedPreferences);

  final String kTheme = 'theme';
  final String kLocale = 'locale';
  final String kUserCredential = 'userCredential';

  /// Default locale set to English
  set locale(String? value) =>
      sharedPreferences.setString(kLocale, value ?? "en");

  String get locale => sharedPreferences.getString(kLocale) ?? "en";

  /// Default theme set to system
  set theme(String? value) => sharedPreferences.setString(
      kTheme, value ?? ActiveTheme.system.description);

  String get theme =>
      sharedPreferences.getString(kTheme) ?? ActiveTheme.system.description;

  /// set and get user Credential

  set userCredentials(String? value) =>
      sharedPreferences.setString(kUserCredential, value!);

  String get userCredentials =>
      sharedPreferences.getString(kUserCredential) ?? '';
  void logout() => sharedPreferences.clear();
}
