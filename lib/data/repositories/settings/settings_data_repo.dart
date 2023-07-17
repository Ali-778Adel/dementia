import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../domain/repository/settings/settings_domain_repo.dart';
import '../../data_sources/local_data_sources/settings/settings_local_data_source.dart';
import '../../models/settings/user_model.dart';

class SettingsDataRepo implements SettingsDomainRepo{
  final SettingsLocalDataSource settingsLocalDataSource;
  SettingsDataRepo({required this.settingsLocalDataSource});
  @override
  Either<Failure, UserModel> getProfileData() {
    try{
      return right(settingsLocalDataSource.getProfileData());
    }catch(e){
      return Left(EmptyCacheFailure());
    }
  }

}