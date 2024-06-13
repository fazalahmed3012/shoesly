import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoesly/AppConstants.dart';
import 'package:shoesly/Components/TitleAppbarWithIcon.dart';
import 'package:shoesly/Controllers/DetailPageController.dart';

import '../Components/ReviewCard.dart';
import '../Models/Review.dart';

class ReviewsPage extends StatefulWidget {
  ReviewsPage({super.key, required this.reviews});

  List<Review> reviews;

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  List<String> brands = [
    "All",
    "5 Stars",
    "4 Stars",
    "3 Stars",
    "2 Stars",
    "1 Stars"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryNeutral0,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: primaryNeutral0,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55.h),
            child: TitleAppbarWithIcon(
              text: Text("Review (${widget.reviews.length})", style: headline400(primaryNeutral500),),
              icon: Row(
                children: [
                  Icon(Icons.star_rounded, color: Colors.amber,size: 20.sp,),
                  Text(context.read<DetailPageController>().getRating(widget.reviews).toString(), style: headline300(primaryNeutral500),)
                ],
              ),
            ),
          ),

          body: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 30.h),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10.w, left: 30.w),
                        child: Text("All", style: headline600(primaryNeutral500),),
                      ),
                      ...List.generate(
                          5,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Text("${index+1} Stars", style: headline600(primaryNeutral300),),
                          )
                      ).reversed
                    ],
                  ),
                ),
              ),

              ...List.generate(
                   widget.reviews.length,
                      (index) => Padding(
                    padding: EdgeInsets.only(top: index!=0?30.h:0, right: 30.w, left: 30.w),
                    child: ReviewCard(review: widget.reviews[index],),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
