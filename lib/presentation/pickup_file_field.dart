
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:time_control/presentation/resources/palette.dart';

class PickUpFileField extends StatelessWidget {
  final String? fieldLabel;
  final Function()onPickTapped;
  const PickUpFileField({Key? key, required this.fieldLabel,required this.onPickTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.sp),
          child: Text(
            fieldLabel ?? "",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Palette.darkBlue),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.sp)),
              border: Border.all(color: Palette.black)),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                child: InkWell(
                  onTap:onPickTapped,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.sp),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.sp, horizontal: 16.sp),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(color: Palette.black),
                      borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                    ),
                    child:const  Text(
                       'اختر ملف',
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
