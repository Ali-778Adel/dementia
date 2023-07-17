import '../../../../../data/models/settings/user_model.dart';

abstract class ProfileStates {}

enum ProfileStatus { success, loading, failure }

class ProfileInitState extends ProfileStates {}

class GetProfileDataState extends ProfileStates {
  final ProfileStatus profileStatus;
  final String? errorMessage;
  final UserModel ?userModel;

  GetProfileDataState({required this.profileStatus,this.userModel, this.errorMessage});
}
