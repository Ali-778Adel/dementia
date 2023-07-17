
enum OTPProgressStatus{loading,success,failure}
enum OTPSuccessStatus{timeOut,completed,codeSent,error,registered}

abstract class OTPStates {}

class OTPInitState extends OTPStates{}

class VerifyPhoneNumberState extends OTPStates{
  final OTPProgressStatus?otpProgressStatus;
  final String? errorMessage;
  final OTPSuccessStatus?otpSuccessStatus;
  final String?verificationId;
  VerifyPhoneNumberState({this.otpProgressStatus,this.errorMessage,this.otpSuccessStatus,this.verificationId});
}

class LinkPhoneNumberWithUserCredentialsState extends OTPStates{
  final OTPProgressStatus?otpProgressStatus;
  final String? errorMessage;
  final OTPSuccessStatus?otpSuccessStatus;
  LinkPhoneNumberWithUserCredentialsState({this.otpProgressStatus,this.otpSuccessStatus,this.errorMessage});
}