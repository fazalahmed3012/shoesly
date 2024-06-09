import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleAppbar extends StatelessWidget {
  TitleAppbar({super.key, required this.text});

  Widget text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){Navigator.pop(context);},
            child: Icon(Icons.arrow_back, size: 24.sp,),
          ),
          text,
          Container(width: 24.sp,)
        ],
      ),
    );
  }
}
