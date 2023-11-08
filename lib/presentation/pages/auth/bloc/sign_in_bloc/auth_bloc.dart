import 'package:firebase_admin/firebase_admin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_control/presentation/pages/auth/bloc/sign_in_bloc/auth_events.dart';
import 'package:time_control/presentation/pages/auth/bloc/sign_in_bloc/auth_states.dart';
import '../../../../../core/error/error_message_fun.dart';
import '../../../../../domain/use_cases/auth/sign_in_with_facebook_use_case.dart';
import '../../../../../domain/use_cases/auth/sign_in_with_google_use_case.dart';


class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final SignInWithFacebookUseCase signInWithFacebookUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;

  AuthBloc(
      {required this.signInWithGoogleUseCase,
      required this.signInWithFacebookUseCase})
      : super(AuthInitState()) {
    on((event, emit) async {
      switch (event.runtimeType) {
        case SignInWithGoogleEvent:
          {
            emit(SignInWithGoogleState(authStatus:AuthStatus.loading));
            final either = await signInWithGoogleUseCase();
            either.fold(
                (l) => emit(
                      SignInWithGoogleState(
                          authStatus: AuthStatus.failure,
                          errorMessage: getErrorMessage(l)),
                    ),
                (r) =>emit(SignInWithGoogleState(
                    authStatus: AuthStatus.success,
                )));
          }
          break;
        case SignInWithFacebookEvent:
          {
            emit(SignInWithFacebookState(authStatus: AuthStatus.loading));
            final either = await signInWithFacebookUseCase();
            either.fold(
                    (l) => emit(
                  SignInWithFacebookState(
                      authStatus: AuthStatus.failure,
                      errorMessage: getErrorMessage(l)),
                ),
                    (r) =>emit(
                  SignInWithFacebookState(
                      authStatus: AuthStatus.success,
                )));
          }break;
      }
    });
  }
}
