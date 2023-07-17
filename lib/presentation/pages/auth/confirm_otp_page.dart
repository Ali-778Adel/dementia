import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_control/presentation/global_widgets/loading.dart';
import 'package:time_control/presentation/pages/auth/bloc/otp_bloc/otp_bloc.dart';
import 'package:time_control/presentation/pages/auth/bloc/otp_bloc/otp_events.dart';
import 'package:time_control/presentation/pages/auth/bloc/otp_bloc/otp_states.dart';
import 'package:time_control/presentation/resources/routes.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';
import '../../../di/dependency-injection.dart';
import '../../resources/palette.dart';

class ConfirmMobilePage extends StatelessWidget {
  // ConfirmMobilePage({Key? key}) : super(key: key);
  final _focusNodes = List.generate(6, (index) => FocusNode());
  final _digitsControllers = List<TextEditingController>.generate(
      6, (index) => TextEditingController());

  final String mobileNumber;
  final String verId;

  ConfirmMobilePage({super.key, required this.mobileNumber,required this.verId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => sl<OTPBloc>(),
      child: BlocListener<OTPBloc, OTPStates>(
        listener: (context, state) {
          if (state is LinkPhoneNumberWithUserCredentialsState) {
            switch (state.otpProgressStatus) {
              case OTPProgressStatus.loading:
                {
                  showDialog(
                      context: context, builder: (context) => const Loading());
                }
                break;
              case OTPProgressStatus.failure:
                {
                  showToast('${state.errorMessage}',
                      dismissOtherToast: true,
                      duration: const Duration(seconds: 6),
                      position: ToastPosition.bottom);
                }
                break;
              case OTPProgressStatus.success:
                {
                  AppRoutes.mainNavigator.currentState!
                      .pushNamedAndRemoveUntil('homePage', (route) => false);
                }
                break;
              default:
                {}
            }
          }
        },
        child: BlocBuilder<OTPBloc, OTPStates>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 148.sp,
                      width: 148.w,
                      child: CircleAvatar(
                        backgroundColor: Palette.primaryBlue,
                        child: Center(
                          child: Icon(
                            Icons.attach_email,
                            size: 40.sp,
                            color: Palette.darkBlue,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 24.sp),
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                              height: 2.sp,
                            ),
                            children: [
                              TextSpan(
                                  text: 'please Enter 6 digit code sent to \n',
                                  style: Theme.of(context).textTheme.bodyText1),
                              TextSpan(
                                  text: '               $mobileNumber \n',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Palette.darkLight)),
                            ]),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.sp),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List<Widget>.generate(
                            6,
                            (index) => Expanded(
                                  child: _digitField(
                                      context: context,
                                      textEditingController:
                                          _digitsControllers[index],
                                      index: index),
                                )),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ));
  }

  Widget _digitField(
      {required BuildContext context,
      required TextEditingController textEditingController,
      required int index}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.sp),
      // width: 30.sp,
      height: 30.sp,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Palette.darkBlue),
      child: Center(
        child: TextField(
          focusNode: _focusNodes[index],
          controller: _digitsControllers[index],
          keyboardType: TextInputType.number,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Palette.white, fontSize: 16.sp),
          textAlign: TextAlign.center,
          // maxLength: 1,
          // maxLengthEnforcement: MaxLengthEnforcement.enforced,
          onChanged: (val) {
            // setState(() {
            if (val.length == 1) {
              if (index == 5) {
                String number = '';
                for (int i = 0; i < 6; i++) {
                  number += _digitsControllers[i].text;
                }
                print(number);
                BlocProvider.of<OTPBloc>(context).add(
                    LinkPhoneNumberWithCredentialEvent(
                        smsCode: number, verificationId: verId));
              } else if (index < 5) {
                _focusNodes[index + 1].requestFocus();
              }
            } else {
              TextInputAction.unspecified;
            }
            // });
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Palette.white, fontSize: 18.sp),
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Palette.black),
                borderRadius: BorderRadius.all(Radius.circular(6.sp))),
          ),
          // onChanged: ,
        ),
      ),
    );
  }
}
