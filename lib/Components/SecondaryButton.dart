import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoesly/AppConstants.dart';

class SecondaryButton extends StatelessWidget {
  SecondaryButton({super.key, required this.text, required this.onTap});

  Function() onTap;
  String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        // width: 109.w,
        height: 50.h,
        padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 24.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            color: primaryNeutral0,
            border: Border.all(color: primaryNeutral200)
        ),
        child: Text(text, style: headline300(primaryNeutral500),),
      ),
    );
  }
}
