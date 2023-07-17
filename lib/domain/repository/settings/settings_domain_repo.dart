import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../data/models/settings/user_model.dart';


abstract class SettingsDomainRepo {
  Either<Failure, UserModel> getProfileData();
}
