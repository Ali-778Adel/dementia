
abstract class SettingsEvents{}

class ChangeAppLocaleEvent extends SettingsEvents{
  final String? locale;
  ChangeAppLocaleEvent({this.locale});
}

class ChangeAppThemeEvent extends SettingsEvents{
  final String?theme;
  ChangeAppThemeEvent({this.theme});
}