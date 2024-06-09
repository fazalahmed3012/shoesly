import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoesly/AppConstants.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 315.w,
      // height: 9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.sp,
            height: 40.sp,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset("assets/profile.png", fit: BoxFit.cover,),
          ),

          Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: SizedBox(
              width: 260.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Maria Saris",style: headline300(primaryNeutral500),),
                      Text("Today")
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
                    child: RatingBarIndicator(
                      rating: 5,
                      itemSize: 12.sp,
                      itemBuilder: (context, index) => Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  
                  Text("Perfect for keeping your feet dry and warm in damp conditions.",
                  style: bodyText100(primaryNeutral500),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
