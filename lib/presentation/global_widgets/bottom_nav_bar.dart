import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../core/localization/strings.dart';
import '../resources/palette.dart';


class CurvedBottomNavBar {
  Function(int)onTap;
  int currentIndex;
  BuildContext context;
  CurvedBottomNavBar({required this.currentIndex,required this.context,required this.onTap});
  CurvedNavigationBar call() {
    return CurvedNavigationBar(
      height:50.0.sp,
      backgroundColor:Palette.white,
      color:Theme.of(context).primaryColor,
      onTap: onTap,
      index:currentIndex ,
      items: [
        Padding(
          padding: const EdgeInsets.all( 4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.home_outlined,
                size: 20.sp,
                color: Palette.white,
              ),
              Text(Strings.of(context)!.home,style: TextStyle(fontSize: 12,color: Palette.white),)
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.qr_code_2_outlined,
                  size: 20.sp,
                  color: Palette.white,
                ),
                 Text(Strings.of(context)!.scan,style:const TextStyle(fontSize: 12,color: Palette.white),)
              ],
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.local_offer,
                  size: 20.sp,
                  color: Palette.white,
                ),
                 Text(Strings.of(context)!.offers,style:const TextStyle(fontSize: 12,color: Palette.white),)
              ],
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.settings,
                  size: 20.sp,
                  color: Palette.white,
                ),
                 Text(Strings.of(context)!.settings,style:const TextStyle(fontSize: 12,color: Palette.white),)
              ],
            ),
          ),
        ),



      ],
    );
  }
}
