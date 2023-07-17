import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_control/presentation/global_widgets/loading.dart';
import 'package:time_control/presentation/pages/auth/bloc/otp_bloc/otp_events.dart';
import 'package:time_control/presentation/pages/auth/bloc/otp_bloc/otp_states.dart';
import 'package:time_control/presentation/resources/palette.dart';
import 'package:time_control/presentation/resources/routes.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';
import '../../../di/dependency-injection.dart';
import 'bloc/otp_bloc/otp_bloc.dart';
import 'confirm_otp_page.dart';

class AddPhoneNumberScreen extends StatelessWidget {
  final phoneField = TextEditingController();

  AddPhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: BlocProvider(
          create: (context) => sl<OTPBloc>(),
          child: BlocListener<OTPBloc, OTPStates>(
            listener: (context, state) {
              if (state is VerifyPhoneNumberState) {
                switch (state.otpProgressStatus) {
                  case OTPProgressStatus.loading:
                    {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: Loading(),
                            );
                          });
                    }
                    break;
                  case OTPProgressStatus.success:
                    {
                      switch (state.otpSuccessStatus) {
                        case OTPSuccessStatus.timeOut:
                          {
                            showToast(
                              'request time out',
                              position: ToastPosition.bottom,
                              duration: const Duration(seconds: 6),
                              dismissOtherToast: true,
                            );
                          }
                          break;
                        case OTPSuccessStatus.codeSent:
                          {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  print(state.verificationId);
                                  return ConfirmMobilePage(
                                      mobileNumber: phoneField.text,
                                       verId:state.verificationId!,

                                  );
                                });
                          }
                          break;
                        case OTPSuccessStatus.error:
                          {
                            Navigator.pop(context);
                            showToast(
                              '${state.errorMessage}',
                              position: ToastPosition.bottom,
                              duration: const Duration(seconds: 6),
                              dismissOtherToast: true,
                            );
                          }
                          break;
                        case OTPSuccessStatus.completed:
                          {
                            Navigator.pop(context);
                            AppRoutes.mainNavigator.currentState!
                                .pushNamed('homePage');
                          }break;
                        default:{}
                      }

                    }break;

                  case OTPProgressStatus.failure:
                    {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SnackBar(
                                content: Container(
                              height: 60.sp,
                              width: 60.sp,
                              padding: EdgeInsets.all(8.sp),
                              child: Text('${state.errorMessage}'),
                            ));
                          });
                    }
                    break;
                  default:
                    {

                    }
                }
              }
            },
            child: BlocBuilder<OTPBloc, OTPStates>(builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: Image.asset(
                        'assets/photos/phone.png',
                        fit: BoxFit.contain,
                      )),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                        'By adding your phone number,you can make your friends and collaporators find you easily'),
                  ),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: phoneField,
                          inputFormatters: <TextInputFormatter>[
                            TextInputFormatter.withFunction(
                                (oldValue, newValue) {
                              return TextEditingValue(
                                  text: newValue.text,
                                  selection: TextSelection.collapsed(
                                      offset: newValue.selection.end));
                            })
                          ],
                          decoration: InputDecoration(
                              icon: const Icon(Icons.phone),
                              helperText:
                                  'please enter your phone number \nwith your country code \n'
                                  'ex: egypt +2 ',
                              label: const Text('phone number'),
                              // errorText: 'please insert right phone number',
                              floatingLabelStyle:
                                  Theme.of(context).textTheme.bodySmall,
                              border: OutlineInputBorder(
                                  gapPadding: 1.0,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.sp)),
                                  borderSide: const BorderSide(
                                      color: Palette.primaryLight)),
                              enabledBorder: OutlineInputBorder(
                                  gapPadding: 1.0,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.sp)),
                                  borderSide: const BorderSide(
                                      color: Palette.primaryLight)),
                              errorBorder: OutlineInputBorder(
                                  gapPadding: 1.0,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.sp)),
                                  borderSide:
                                      const BorderSide(color: Palette.red)),
                              focusedBorder: OutlineInputBorder(
                                  gapPadding: 1.0,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.sp)),
                                  borderSide:
                                      const BorderSide(color: Palette.black))),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<OTPBloc>(context).add(
                            VerifyPhoneNumberEvent(
                                phoneNumber: phoneField.text));
                      },
                      child: const Text('ok'),
                    ),
                  )
                ],
              );
            }),
          ),
        ));
  }
}
