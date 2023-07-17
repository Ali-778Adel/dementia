import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_control/presentation/global_widgets/alert_dialog.dart';
import 'package:time_control/presentation/pages/settings/blocs/settings_main_bloc/settings_events.dart';
import 'package:time_control/presentation/resources/dimens.dart';
import 'package:time_control/presentation/resources/palette.dart';
import 'package:time_control/presentation/resources/routes.dart';
import 'package:sizer/sizer.dart';
import '../../../core/localization/strings.dart';
import '../../../data/data_sources/local_data_sources/pref_manger.dart';
import '../../../di/dependency-injection.dart';
import '../../global_widgets/drop_down.dart';
import 'blocs/settings_main_bloc/settings_bloc.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final _themeList = (BuildContext context) =>[
    Strings.of(context)!.themeDark,
    Strings.of(context)!.themeLight,
    Strings.of(context)!.themeSystem,
      ];

  final _localeList = <dynamic>[
    'العربية',
    'english',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          Strings.of(context)!.settings,
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileField(context),
          _buildLanguageField(context),
          _buildThemeField(context),
          _logoutField(context)
        ],
      ),
    );
  }

  Widget _buildProfileField(BuildContext context) {
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 0.sp),
            child: Text(
              Strings.of(context)!.profile,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Palette.hint),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Palette.hint.withOpacity(.2))),),
            child: ListTile(dense: false,contentPadding:const EdgeInsets.all(0.0),
              leading: Padding(padding: EdgeInsets.only(left: Dimens.space12),
                child: const Icon(Icons.person,),),
              title: Text(
                Strings.of(context)!.profileData,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 10.sp,
              ),
            ),
          ),
        ],
      ),
      onTap: () => Navigator.pushNamed(context, 'profileScreen'),
    );
  }

  Widget _buildLanguageField(BuildContext context) {
    return DropDown(
      key: const Key("dropdown_locale"),
      hint: Strings.of(context)!.selectLanguage,
      value: sl<PrefManger>().locale == 'en'
          ? '${_localeList[1]}'
          : _localeList[0],
      prefixIcon: const Icon(Icons.language),
      items: _localeList
          .map(
            (data) => DropdownMenuItem(
              value: data,
              child: Text(
                data,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          )
          .toList(),
      hintIsVisible: true,
      onChanged: (value) {
        if (value != null) {
          if (value == _localeList[0]) {
            BlocProvider.of<SettingsBloc>(context)
                .add(ChangeAppLocaleEvent(locale: 'ar'));
          }
          if (value == _localeList[1]) {
            BlocProvider.of<SettingsBloc>(context)
                .add(ChangeAppLocaleEvent(locale: 'en'));
          }
        }
      },
    );
  }

  Widget _buildThemeField(BuildContext context) {
    return DropDown(
      key: const Key("dropdown_theme"),
      hintIsVisible: true,
      hint: Strings.of(context)!.selectTheme,
      value: getSelectedTheme(context),
      prefixIcon: const Icon(Icons.light),
      items: _themeList(context)
          .map(
            (data) => DropdownMenuItem(
              value: data,
              child: Text(data,style: Theme.of(context).textTheme.bodyMedium,),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == _themeList(context)[0]) {
          BlocProvider.of<SettingsBloc>(context).add(ChangeAppThemeEvent(theme: 'dark'));}
        else if (value == _themeList(context)[1]) {
          BlocProvider.of<SettingsBloc>(context).add(ChangeAppThemeEvent(theme: 'light'));}
        else {
          BlocProvider.of<SettingsBloc>(context).add(ChangeAppThemeEvent(theme: 'system'));
        }
      },
    );
  }

  Widget _logoutField(BuildContext context) {
    return InkWell(
      child: Container(
        height: 60.sp,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Palette.hint.withOpacity(.2)))),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: Dimens.space12,
              ),
              child: const Icon(Icons.logout),
            ),
            SizedBox(
              width: 8.sp,
            ),
            Text(
              Strings.of(context)!.logout,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 10.sp,
            ),
          ],
        ),
      ),
      onTap: () {
        MyAlertDialog(
            context: context,
            bodyText: Strings.of(context)!.logOutMessage,
            onConfirm: () {
              sl<PrefManger>().logout();
              Navigator.pop(context);
              AppRoutes.mainNavigator.currentState!
                  .pushNamedAndRemoveUntil('/', (route) => false);
            }).call();
      },
    );
  }

  String getSelectedTheme(BuildContext context) {
    var selectedTheme = '';
    if (sl<PrefManger>().theme == ActiveTheme.system.description) {
      selectedTheme = Strings.of(context)!.themeSystem;
    } else if (sl<PrefManger>().theme == ActiveTheme.light.description) {
      selectedTheme = Strings.of(context)!.themeLight;
    } else {
      selectedTheme = Strings.of(context)!.themeDark;
    }
    return selectedTheme;
  }
}
