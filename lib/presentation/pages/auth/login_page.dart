import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_control/presentation/pages/auth/bloc/sign_in_bloc/auth_bloc.dart';
import 'package:time_control/presentation/pages/auth/bloc/sign_in_bloc/auth_events.dart';
import 'package:time_control/presentation/pages/auth/bloc/sign_in_bloc/auth_states.dart';
import 'package:time_control/presentation/resources/palette.dart';
import 'package:sizer/sizer.dart';

import '../../../core/localization/strings.dart';
import '../../../di/dependency-injection.dart';
import '../../global_widgets/loading.dart';
import '../../global_widgets/message_bottom_sheet.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});
final GlobalKey<ScaffoldState>_scaffoldState=GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      backgroundColor: Palette.white,
      body: BlocListener<AuthBloc, AuthStates>(
          listener: (context, state) {
           if(state is SignInWithGoogleState){
             switch (state.authStatus){
               case AuthStatus.loading:{
                 showDialog(
                     context: context,
                     builder: (context) {
                       return const SizedBox(
                         height: 150,
                         width: 150,
                         child: Loading(),
                       );
                     });
               }break;
               case AuthStatus.success:{
                 if(sl<FirebaseAuth>().currentUser!.phoneNumber==null){
                   Navigator.pushNamed(context, 'phonePage');
                 }else{
                   Navigator.pushNamed(context, 'homePage');
                 }
               }break;
               case AuthStatus.failure:{
                 Navigator.pop(context);
                 _scaffoldState.currentState!.showBottomSheet(
                         (context) => MessageBottomSheet(message: state.errorMessage,onAction: (){
                           BlocProvider.of<AuthBloc>(context).add(SignInWithGoogleEvent());

                         },),
                   backgroundColor: Palette.white,
                 );

              }break;
               default:{
                 print('some wrong had happened');
               }
             }
           }
           if(state is SignInWithFacebookState){
             switch (state.authStatus){
               case AuthStatus.loading:{
                 showDialog(
                     context: context,
                     builder: (context) {
                       return const SizedBox(
                         height: 150,
                         width: double.infinity,
                         child: Loading(),
                       );
                     });
               }break;
               case AuthStatus.success:{
                 Navigator.pushNamed(context, 'homePage');
               }break;
               case AuthStatus.failure:{
                 Navigator.pop(context);
                 _scaffoldState.currentState!.showBottomSheet(
                       (context) => MessageBottomSheet(message: state.errorMessage,onAction: (){
                         BlocProvider.of<AuthBloc>(context).add(SignInWithFacebookEvent());

                       },),
                   backgroundColor: Palette.white,
                 );               }break;
               default:{
                 print('some wrong had happened');
               }
             }
           }

          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(8.sp),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 4, child: Image.asset('assets/gifs/login.gif')),
                  Text(Strings.of(context)!.loginDescription,
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Palette.black,
                            // overflow: TextOverflow.visible
                              )),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    Strings.of(context)!.loginBy,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Palette.darkBlue),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Expanded(
                      child: Wrap(
                    children: [
                      InkWell(
                        child: SizedBox(
                            height: 25.sp,
                            width: 25.sp,
                            child: Image.asset(
                              'assets/icons/google.png',
                              fit: BoxFit.contain,
                            )),
                        onTap: () {
                          BlocProvider.of<AuthBloc>(context).add(SignInWithGoogleEvent());
                        },
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      InkWell(
                        child: SizedBox(
                            height: 25.sp,
                            width: 25.sp,
                            child: Image.asset(
                              'assets/icons/facebook.png',
                              fit: BoxFit.contain,
                            )),
                        onTap: () {
                          BlocProvider.of<AuthBloc>(context).add(SignInWithFacebookEvent());
                        },
                      ),
                    ],
                  ))
                ],
              ),
            ),
          )),
    );
  }
}
