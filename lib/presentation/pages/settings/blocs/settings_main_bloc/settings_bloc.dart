import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_control/presentation/pages/settings/blocs/settings_main_bloc/settings_events.dart';
import 'package:time_control/presentation/pages/settings/blocs/settings_main_bloc/settings_states.dart';
import '../../../../../data/data_sources/local_data_sources/pref_manger.dart';
import '../../../../../di/dependency-injection.dart';

class SettingsBloc extends Bloc<SettingsEvents,SettingsStates>{

  static SettingsBloc get(context)=>BlocProvider.of(context);

  SettingsBloc():super(SettingsBlocInitState()){
    on((event, emit) {
      if(event is ChangeAppLocaleEvent){
        sl<PrefManger>().locale=event.locale;
        emit(ChangeAppLocaleState());
      }
      if(event is ChangeAppThemeEvent){
        sl<PrefManger>().theme=event.theme;
        emit(ChangeAppThemeState());
      }
    });
  }

}