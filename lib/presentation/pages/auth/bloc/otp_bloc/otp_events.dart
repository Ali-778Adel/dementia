import 'package:flutter/material.dart';

abstract class OTPEvents{}

class VerifyPhoneNumberEvent extends OTPEvents{
  final String phoneNumber;
  VerifyPhoneNumberEvent({required this.phoneNumber});
}

class LinkPhoneNumberWithCredentialEvent extends OTPEvents{
  final String verificationId;
  final String smsCode;
  LinkPhoneNumberWithCredentialEvent({required this.smsCode,required this.verificationId});
}
