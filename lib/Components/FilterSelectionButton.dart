import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoesly/AppConstants.dart';

class FilterSelectionButton extends StatelessWidget {
  FilterSelectionButton({super.key, required this.text, required this.onTap, this.isSelected});

  bool? isSelected;
  String text;
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
          color: isSelected?? true ? primaryNeutral600 : primaryNeutral0,
        ),
        child: Text(text, style: headline300(isSelected?? true ? primaryNeutral0 : primaryNeutral500),),
      ),
    );
  }
}
