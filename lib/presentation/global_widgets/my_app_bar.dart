import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyAppBar{
  final String?appBarTitle;
  final bool isSubWidget;
  final Function()? onTabBack;
  MyAppBar({this.appBarTitle,required this.isSubWidget,this.onTabBack});

  PreferredSizeWidget call(BuildContext context){
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    title:Text(appBarTitle??'',style: Theme.of(context).textTheme.bodyMedium,),
    centerTitle: true,
    leading: InkWell(
      onTap: onTabBack,
      child:isSubWidget?

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.sp),
          child: const Icon(Icons.arrow_back_outlined),
        )

     :null,
    ),

  );
  }

}