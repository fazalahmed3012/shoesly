import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoesly/AppConstants.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        children: [
          /// Image
          Container(
            margin: EdgeInsets.only(right: 15.w),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            width: 88.w,
              height: 88.h,
              decoration: BoxDecoration(
                color: primaryNeutral100,
                borderRadius: BorderRadius.circular(25.r)
              ),
              child: Image.asset("assets/0.png", width: 70.w,)
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Jordan 1 Retro High Tie Dye", style: headline400(primaryNeutral500),),
              Padding(
                padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
                child: Text("Nike . Red Grey . 40", style: bodyText100(primaryNeutral400),),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 30.w),
                    width: 110.w,
                      child: Text("\$235.00", style: headline300(primaryNeutral500),)
                  ),

                  Icon(CupertinoIcons.minus_circle, size: 20.sp,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text("1", style: headline300(primaryNeutral500),),
                  ),
                  Icon(CupertinoIcons.add_circled, size: 20.sp,),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
