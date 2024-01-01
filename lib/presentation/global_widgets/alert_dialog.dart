import 'package:flutter/material.dart';
import 'package:time_control/presentation/resources/palette.dart';
import 'package:sizer/sizer.dart';

import '../../core/localization/strings.dart';

class MyAlertDialog{
 final BuildContext context;
 final String bodyText;
 final Function()onConfirm;
  MyAlertDialog({required this.context,required this.bodyText,required this.onConfirm});
  void call(){
    showDialog(
        context: context,
        builder: (context){
      return Center(
        child: Container(
          height: 20.h,
          width: 60.w,
          decoration: BoxDecoration(
            border: Border.all(color: Palette.black10),
            color: Palette.hint,
            boxShadow:const [
              BoxShadow(
                offset: Offset(10, 10),
                color: Palette.lightGrey,
                blurStyle:BlurStyle.inner,
                blurRadius: 4
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(10.sp))
          ),
          padding: EdgeInsets.all(16.sp),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Text(bodyText,style: Theme.of(context).textTheme.bodySmall,),
              const Spacer(),
              Row(
                children: [
                  Expanded(child:  Center(child: TextButton(child: Text(Strings.of(context)!.cancel,style: Theme.of(context).textTheme.bodySmall,),onPressed: ()=>Navigator.pop(context),))),
                  const Divider(color: Palette.black,thickness: 2,),
                  Expanded(child:  Center(child: TextButton(onPressed: onConfirm,child: Text(Strings.of(context)!.yes,style: Theme.of(context).textTheme.bodySmall),)))
                ],
              )

            ],
          ),
        ),
      );
        }
        ,barrierColor: Colors.transparent
        );
  }

}