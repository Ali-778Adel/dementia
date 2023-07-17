import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../resources/palette.dart';


class CurvedBottomNavBar {
  Function(int)onTap;
  int currentIndex;
  CurvedBottomNavBar({required this.currentIndex,required this.onTap});
  CurvedNavigationBar call() {
    return CurvedNavigationBar(
      height:50.0,
      backgroundColor:Palette.white,
      color:Palette.primary,
      onTap: onTap,
      index:currentIndex ,
      items: [
        Icon(
          Icons.home_outlined,
          size: 20.sp,
          color: Palette.white,
        ),
        Icon(
          Icons.settings,
          size: 20.sp,
          color: Palette.white,
        ),
      ],
    );
  }
}
