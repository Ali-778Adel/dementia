import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_control/core/error/error_message_fun.dart';
import 'package:time_control/presentation/pages/auth/bloc/otp_bloc/otp_events.dart';
import 'package:time_control/presentation/pages/auth/bloc/otp_bloc/otp_states.dart';

import '../../../../../domain/use_cases/auth/link_phone_number_use_case.dart';
import '../../../../../domain/use_cases/auth/verify_phone_number_use_case.dart';

class OTPBloc extends Bloc<OTPEvents, OTPStates> {
  final VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;
  final LinkWithPhoneNumberUseCase linkWithPhoneNumberUseCase;

  OTPBloc(
      {required this.verifyPhoneNumberUseCase,
      required this.linkWithPhoneNumberUseCase})
      : super(OTPInitState()) {
    on((event, emit) async {
      if (event is VerifyPhoneNumberEvent) {
        emit(VerifyPhoneNumberState(
          otpProgressStatus: OTPProgressStatus.loading
        ));
        try{
          await handlePhoneNumberVerification(event.phoneNumber);
          switch(event.verifyingPhoneNumberStatus){
            case VerifyingPhoneNumberStatus.completed:{
              emit(VerifyPhoneNumberState(
                otpSuccessStatus: OTPSuccessStatus.completed,
                otpProgressStatus: OTPProgressStatus.success,
              ));
            }break;
            case VerifyingPhoneNumberStatus.codeSent:{
              emit(VerifyPhoneNumberState(
                  otpSuccessStatus: OTPSuccessStatus.codeSent,
                  otpProgressStatus: OTPProgressStatus.success,
                  verificationId: event.verificationId
              ));
            }break;
            case VerifyingPhoneNumberStatus.failed:{
              emit(VerifyPhoneNumberState(
                errorMessage: event.errorMessage,
                otpSuccessStatus: OTPSuccessStatus.error,
                otpProgressStatus: OTPProgressStatus.success,
                // errorMessage:
              ));
            }break;
            case VerifyingPhoneNumberStatus.timeOut:{
              emit(VerifyPhoneNumberState(
                otpSuccessStatus: OTPSuccessStatus.timeOut,
                otpProgressStatus: OTPProgressStatus.success,
              ));
            }break;
            default :{

            }
          }
        }catch(exception){
          emit(VerifyPhoneNumberState(
            otpProgressStatus: OTPProgressStatus.failure,
            errorMessage: exception.toString()
          ));
        }


      }
      //
      //   //
      //   // either.fold((l) {
      //   //   emit(VerifyPhoneNumberState(
      //   //       otpProgressStatus: OTPProgressStatus.failure,
      //   //       errorMessage: getErrorMessage(l)));
      //   // }, (r) {
      //   //   if (r == 'timeOut') {
      //   //     emit(VerifyPhoneNumberState(
      //   //         otpProgressStatus: OTPProgressStatus.success,
      //   //         otpSuccessStatus: OTPSuccessStatus.timeOut));
      //   //   } else if (r == 'completed') {
      //   //     emit(VerifyPhoneNumberState(
      //   //         otpProgressStatus: OTPProgressStatus.success,
      //   //         otpSuccessStatus: OTPSuccessStatus.completed));
      //   //   } else if (r.substring(0, 8) == 'codeSent') {
      //   //     emit(VerifyPhoneNumberState(
      //   //         otpProgressStatus: OTPProgressStatus.success,
      //   //         otpSuccessStatus: OTPSuccessStatus.codeSent,
      //   //         verificationId: r.substring(8, r.length)));
      //   //   } else {
      //   //     emit(VerifyPhoneNumberState(
      //   //         otpProgressStatus: OTPProgressStatus.success,
      //   //         otpSuccessStatus: OTPSuccessStatus.error,
      //   //         errorMessage: r));
      //   //   }
      //   //   emit(VerifyPhoneNumberState(
      //   //       otpProgressStatus: OTPProgressStatus.success));
      //   // });
      // }
      if (event is LinkPhoneNumberWithCredentialEvent) {
        emit(LinkPhoneNumberWithUserCredentialsState(
            otpProgressStatus: OTPProgressStatus.loading));
        final either = await linkWithPhoneNumberUseCase(
            smsCode: event.smsCode, verificationId: event.verificationId);
        either.fold(
            (l) => emit(LinkPhoneNumberWithUserCredentialsState(
                otpProgressStatus: OTPProgressStatus.failure,
                errorMessage: getErrorMessage(l))), (r) {
          emit(LinkPhoneNumberWithUserCredentialsState(
            otpProgressStatus: OTPProgressStatus.success,
          ));
        });
      }
    });
  }

  Future<void> handlePhoneNumberVerification(String?phoneNumber)async{
    await verifyPhoneNumberUseCase(
        phoneNumber: phoneNumber!,
        verificationCompleted: (userCredential)async {
          add(VerifyPhoneNumberEvent(phoneNumber: phoneNumber, verifyingPhoneNumberStatus: VerifyingPhoneNumberStatus.completed));
        },
        verificationFailed: (exception)async {
          add(VerifyPhoneNumberEvent(phoneNumber: phoneNumber, verifyingPhoneNumberStatus: VerifyingPhoneNumberStatus.failed));
        },
        codeSent: (verificationId, tokenId)async {
          add(VerifyPhoneNumberEvent(phoneNumber: phoneNumber, verifyingPhoneNumberStatus: VerifyingPhoneNumberStatus.codeSent,verificationId: verificationId));
        },
        timeout: const Duration(seconds: 120),
        codeAutoRetrievalTimeout: (x)async {
          add(VerifyPhoneNumberEvent(phoneNumber: phoneNumber, verifyingPhoneNumberStatus: VerifyingPhoneNumberStatus.timeOut));
        });
  }

}

