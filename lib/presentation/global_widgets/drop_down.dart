import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../resources/dimens.dart';
import '../resources/palette.dart';


class DropDown<T> extends StatelessWidget {
  final T value;
  final List<DropdownMenuItem<T>> items;
  final bool hintIsVisible;
  final String? hint;
  final ValueChanged<T?>? onChanged;
  final Widget? prefixIcon;

  const DropDown({super.key, required this.value, required this.items, required this.hintIsVisible, this.hint, this.onChanged, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: hintIsVisible,
          child: Text(
            hint ?? "",
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: Theme.of(context).hintColor),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4.sp),
          child: ButtonTheme(
            height: 36.h,
            key: key,
            alignedDropdown: true,
            padding: EdgeInsets.zero,
            child: DropdownButtonFormField(
              isExpanded: false,
              icon: const Icon(Icons.arrow_drop_down),
              decoration: InputDecoration(
                alignLabelWithHint: true,
                isDense: false,
                isCollapsed: false,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: Dimens.space12),
                  child: prefixIcon,
                ),
                prefixIconConstraints: BoxConstraints(
                  minHeight: Dimens.space24,
                  maxHeight: Dimens.space24,
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: Dimens.space12),
                // enabledBorder: OutlineInputBorder(
                //   gapPadding: 0,
                //   borderRadius: BorderRadius.circular(Dimens.space4),
                //   borderSide:  const BorderSide(color: Palette.disable),
                // ),
                // focusedErrorBorder: OutlineInputBorder(
                //   gapPadding: 0,
                //   borderRadius: BorderRadius.circular(Dimens.space4),
                //   borderSide: const BorderSide(color: Palette.red),
                // ),
                // errorBorder: OutlineInputBorder(
                //   gapPadding: 0,
                //   borderRadius: BorderRadius.circular(Dimens.space4),
                //   borderSide: const BorderSide(color: Palette.red),
                // ),
                // focusedBorder: OutlineInputBorder(
                //   gapPadding: 0,
                //   borderRadius: BorderRadius.circular(Dimens.space4),
                //   borderSide: const BorderSide(color: Palette.primary),
                // ),
              ),
              value: value,
              items:items,
              onChanged:onChanged,
            ),
          ),
        ),
      ],
    );
  }
}