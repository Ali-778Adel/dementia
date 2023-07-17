// ignore_for_file: file_names


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_sources/local_data_sources/pref_manger.dart';
import '../data/data_sources/local_data_sources/settings/settings_local_data_source.dart';
import '../data/data_sources/remote_data_sources/auth/auth_remote_data_source.dart';
import '../data/repositories/auth/auth_data_repo.dart';
import '../data/repositories/settings/settings_data_repo.dart';
import '../domain/repository/auth/auth_domain_repo.dart';
import '../domain/repository/settings/settings_domain_repo.dart';
import '../domain/use_cases/auth/link_phone_number_use_case.dart';
import '../domain/use_cases/auth/post_user_data_use_case.dart';
import '../domain/use_cases/auth/sign_in_with_facebook_use_case.dart';
import '../domain/use_cases/auth/sign_in_with_google_use_case.dart';
import '../domain/use_cases/auth/verify_phone_number_use_case.dart';
import '../domain/use_cases/settings/get_profile_data_use_case.dart';
import '../presentation/pages/auth/bloc/otp_bloc/otp_bloc.dart';
import '../presentation/pages/auth/bloc/sign_in_bloc/auth_bloc.dart';
import '../presentation/pages/settings/blocs/profile_bloc/profile_bloc.dart';
import '../presentation/pages/settings/blocs/settings_main_bloc/settings_bloc.dart';
import '../utils/services/firebase_messaging_service.dart';
import '../utils/services/firebase_services.dart';
import '../utils/services/internet_connection_checker.dart';
import '../utils/services/local_notifications_service.dart';

/// init GetIt dependency
final sl = GetIt.instance;

/// register sl to app
Future<void> serviceLocator()async{
  initPreManger();
  initAppBlocs();
  initAppDependencies();
  initFirebaseFeatures();
  initAppRepos();
  initAppRemoteDataSources();
  initAppUseCases();
  initAppInterfaces();
  initAppLocalDataSources();
  initAppServices();
}

///sharedPre Initialization
///path to class PrefManger in data/local_data_sources/pref_manger
Future<void>initPreManger()async{
  await SharedPreferences.getInstance().then((value) {
  sl.registerLazySingleton<PrefManger>(() => PrefManger(value));
  });
}

///init app blocs
void initAppBlocs(){
  sl.registerFactory<SettingsBloc>(() => SettingsBloc());
  sl.registerFactory<AuthBloc>(() => AuthBloc(signInWithGoogleUseCase: sl(), signInWithFacebookUseCase: sl()));
  sl.registerFactory<ProfileBloc>(() =>ProfileBloc(getProfileDataUseCase: sl()) );
  sl.registerFactory<OTPBloc>(() => OTPBloc(verifyPhoneNumberUseCase: sl(), linkWithPhoneNumberUseCase: sl()));
}

///app useCases
void initAppUseCases(){
  /// auth feature
  sl.registerLazySingleton<SignInWithGoogleUseCase>(() =>SignInWithGoogleUseCase(authDomainRepo: sl()));
  sl.registerLazySingleton<SignInWithFacebookUseCase>(() => SignInWithFacebookUseCase(authDomainRepo: sl()));
  sl.registerLazySingleton<GetProfileDataUseCase>(() => GetProfileDataUseCase(settingsDomainRepo: sl()));
  sl.registerLazySingleton<PostUserDataUseCase>(() => PostUserDataUseCase(authDomainRepo: sl()));
  sl.registerLazySingleton<VerifyPhoneNumberUseCase>(() => VerifyPhoneNumberUseCase(authDomainRepo: sl()));
  sl.registerLazySingleton<LinkWithPhoneNumberUseCase>(() => LinkWithPhoneNumberUseCase(authDomainRepo: sl()));
}

///init app repositories
void initAppRepos(){
  sl.registerLazySingleton<AuthDomainRepo>(() => AuthDataRepo(networkInfo: sl(), authRemoteDataSource: sl()));
  sl.registerLazySingleton<SettingsDomainRepo>(() => SettingsDataRepo(settingsLocalDataSource: sl()));
}

/// init appDataSources
void initAppRemoteDataSources(){
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource());
}

///init AppLocal Data Sources
void initAppLocalDataSources(){
  sl.registerLazySingleton<SettingsLocalDataSource>(() => SettingsLocalDataSource());
}


///init app services
void initAppDependencies(){
  sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());
  // sl.registerLazySingleton<FlutterLocalNotificationsPlugin>(() => FlutterLocalNotificationsPlugin());
}
///init app interfaces
void initAppInterfaces(){
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnectionChecker: sl()));

}
///register firebase used features
void initFirebaseFeatures(){
  sl.registerLazySingleton<FirebaseService>(() => FirebaseService());
  sl.registerLazySingleton<FirebaseMessagingService>(() =>FirebaseMessagingService());
  sl.registerLazySingleton<FirebaseAdmin>(() => FirebaseAdmin.instance);
  sl.registerLazySingleton<FirebaseAuth>(() =>FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseMessaging>(() => FirebaseMessaging.instance);
}

void initAppServices(){
  sl.registerLazySingleton<LocalNotificationService>(() => LocalNotificationService());
}
