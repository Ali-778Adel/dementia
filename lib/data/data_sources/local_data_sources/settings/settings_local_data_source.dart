import 'dart:convert';
import '../../../../di/dependency-injection.dart';
import '../../../models/settings/user_model.dart';
import '../pref_manger.dart';



class SettingsLocalDataSource{
  UserModel getProfileData(){
    final profileData= sl<PrefManger>().userCredentials;
    final stringToObject=json.decode(profileData) ;
    final res=UserModel.fromJson(stringToObject);
    return res;
  }

}
