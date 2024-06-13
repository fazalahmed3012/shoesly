import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleAppbarWithIcon extends StatelessWidget {
  TitleAppbarWithIcon({super.key, required this.text, required this.icon});

  Widget text;
  Widget icon;

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
          icon,
        ],
      ),
    );
  }
}
