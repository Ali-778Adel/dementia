import 'package:dartz/dartz.dart';
import 'package:time_control/domain/repository/settings/settings_domain_repo.dart';
import '../../../core/error/failures.dart';
import '../../../data/models/settings/user_model.dart';

class GetProfileDataUseCase {
  final SettingsDomainRepo settingsDomainRepo;

  GetProfileDataUseCase({required this.settingsDomainRepo});

  Either<Failure, UserModel> call() {
    return settingsDomainRepo.getProfileData();
  }
}
