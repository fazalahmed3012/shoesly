import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoesly/AppConstants.dart';
import 'package:shoesly/Models/ProductColor.dart';

class ColorFilterButton extends StatelessWidget {
  ColorFilterButton({super.key, required this.color, required this.onTap, this.isSelected});

  bool? isSelected;
  ProductColor color;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        // width: 109.w,
        height: 40.h,
        padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 20.w),
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected?? true ? primaryNeutral600 : primaryNeutral200
          ),
          borderRadius: BorderRadius.circular(100.r),
          color: primaryNeutral0,
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Container(
                width: 20.sp,
                height: 20.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(color.color)
                ),
              ),
            ),
            Text(color.name, style: headline400(primaryNeutral500),),
          ],
        ),
      ),
    );
  }
}
