import 'package:flutter/material.dart';

enum VerifyingPhoneNumberStatus{completed,codeSent,failed,timeOut}
abstract class OTPEvents{}


class VerifyPhoneNumberEvent extends OTPEvents{
   String? phoneNumber;
   String?verificationId;
   VerifyingPhoneNumberStatus ?verifyingPhoneNumberStatus;
   String?errorMessage;
  VerifyPhoneNumberEvent({
    this.phoneNumber,
    this.verifyingPhoneNumberStatus,
    this.verificationId,
    this.errorMessage,

  });
}

class LinkPhoneNumberWithCredentialEvent extends OTPEvents{
  final String verificationId;
  final String smsCode;
  LinkPhoneNumberWithCredentialEvent({required this.smsCode,required this.verificationId});
}
