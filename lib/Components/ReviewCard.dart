import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoesly/AppConstants.dart';
import 'package:shoesly/Controllers/DetailPageController.dart';
import 'package:shoesly/Models/Review.dart';

class ReviewCard extends StatelessWidget {
  ReviewCard({super.key, required this.review});

  Review review;

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
            child: CachedNetworkImage(
              imageUrl: review.userImage,
              width: 120.w,
              height: 85.h,
              fit: BoxFit.cover,
              placeholder: (context, str) {
                return Image.asset(
                  'assets/profilePlaceholder.png',
                  fit: BoxFit.contain,
                );
              },
              errorWidget: (context, str, obj) {
                return Image.asset(
                  'assets/profilePlaceholder.png',
                  fit: BoxFit.contain,
                );
              },
            )
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
                      Text(review.userName,style: headline300(primaryNeutral500),),
                      Text(context.read<DetailPageController>().getTimeDifference(DateTime.parse(review.createdOn)))
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
                    child: RatingBarIndicator(
                      rating: review.rating,
                      itemSize: 12.sp,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  
                  Text(review.review,
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
