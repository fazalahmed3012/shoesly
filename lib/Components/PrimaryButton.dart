import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoesly/AppConstants.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({super.key, required this.text, required this.onTap});

  String text;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        // width: 109.w,
        height: 50.h,
        padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 24.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            color: primaryNeutral600,
        ),
        child: Text(text, style: headline300(primaryNeutral0),),
      ),
    );
  }
}
