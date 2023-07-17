import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_control/presentation/pages/settings/blocs/profile_bloc/profile_events.dart';
import 'package:time_control/presentation/pages/settings/blocs/profile_bloc/profile_states.dart';
import '../../../../../core/error/error_message_fun.dart';
import '../../../../../domain/use_cases/settings/get_profile_data_use_case.dart';

class ProfileBloc extends Bloc<ProfileEvents, ProfileStates> {
  final GetProfileDataUseCase getProfileDataUseCase;
  ProfileBloc({required this.getProfileDataUseCase})
      : super(ProfileInitState()) {
    on((event, emit) {
      if (event is GetProfileDataEvent) {
        emit(GetProfileDataState(profileStatus: ProfileStatus.loading));
        final either = getProfileDataUseCase();
        either.fold(
            (l) => emit(GetProfileDataState(
                profileStatus: ProfileStatus.failure,
                errorMessage: getErrorMessage(l))),
            (r) => emit(GetProfileDataState(
                profileStatus: ProfileStatus.success, userModel: r)));
      }
    });
  }


}
