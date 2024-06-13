import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoesly/AppConstants.dart';

class IconLeftButton extends StatelessWidget {
  IconLeftButton({super.key, required this.text, required this.icon, required this.onTap});

  Function() onTap;
  String text;
  Widget icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // width: 109.w,
        height: 50.h,
        padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 24.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          color: primaryNeutral600
        ),
        child: Wrap(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: icon,
            ),
            Text(text, style: headline400(primaryNeutral0),)
          ],
        ),
      ),
    );
  }
}
