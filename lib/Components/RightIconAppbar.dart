import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RightIconAppbar extends StatelessWidget {
  RightIconAppbar({super.key, required this.icon});

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
          icon
        ],
      ),
    );
  }
}
