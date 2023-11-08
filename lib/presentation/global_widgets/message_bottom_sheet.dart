import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../resources/palette.dart';

class MessageBottomSheet extends StatelessWidget {
  final String ?message;
  final Function()onAction;
  const MessageBottomSheet({Key? key,required this.message,required this.onAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
          margin:  EdgeInsets.all(8.sp),
          // height: 120.sp,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Palette.white,
              border: Border.all(
                color: Palette.black10,
              ),
              borderRadius:const BorderRadius.all(Radius.circular(20)),
              boxShadow:const [
                BoxShadow(
                    color: Palette.red,
                    blurRadius: .3,
                    spreadRadius: 2,
                    offset: Offset(1,2)
                ),
                BoxShadow(
                    color: Palette.red,
                    blurRadius: .3,
                    spreadRadius: 2,
                    offset: Offset(0,2)
                ),
              ]
          ),
          child: Column(
            children: [
              Center(child: Text("$message",style:const TextStyle(color: Palette.red),)),
              SizedBox(height: 15.sp,),
              ElevatedButton(
                  style: const ButtonStyle(

                  ),
                  onPressed: onAction,
                  child: const Text(
                      'try again'
                  ))
            ],
          )
      ),
    );
  }
}
