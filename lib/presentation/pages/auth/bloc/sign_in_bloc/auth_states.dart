abstract class AuthStates {}

enum AuthStatus { success, failure, loading }

class AuthInitState extends AuthStates {}

class SignInWithGoogleState extends AuthStates {
  final String? errorMessage;
  final AuthStatus authStatus;
  SignInWithGoogleState({this.errorMessage, required this.authStatus});
}

class SignInWithFacebookState extends AuthStates {
  final String? errorMessage;
  final AuthStatus authStatus;
  SignInWithFacebookState({this.errorMessage, required this.authStatus});
}

class GetUserCredentialState extends AuthStates {}
