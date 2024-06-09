import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../AppConstants.dart';
import '../Models/Brand.dart';

class ProductGridTile extends StatelessWidget {
  ProductGridTile(
      {
        required this.name,
        required this.images,
        required this.price,
        required this.reviews,
        required this.brand,
        required this.rating,
        super.key
      }
    );

  String name;
  String images;
  double price;
  int reviews;
  double rating;
  Brand brand;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// Image Container
        Container(
          margin: EdgeInsets.only(bottom: 10.h),
          width: 150.w,
          height: 150.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            color: primaryNeutral500.withOpacity(0.05),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15.h, bottom: 4.h, left: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CachedNetworkImage(
                        imageUrl: brand.image,
                      width: 24.w,
                    ),
                    // Image.asset(brand.image, width: 24.w,),
                  ],
                ),
              ),

              CachedNetworkImage(
                  imageUrl: images,
                width: 120.w,
                height: 85.h,
                placeholder: (context, str) {
                  return Image.asset(
                    'assets/placeHolder.png',
                    fit: BoxFit.contain,
                  );
                },
                errorWidget: (context, str, obj) {
                  return Image.asset(
                    'assets/placeHolder.png',
                    fit: BoxFit.contain,
                  );
                },
              ),
              // Image.asset(images, width: 120.w, height: 85.h,)
            ],
          ),
        ),

        /// Product Name
        Padding(
          padding: EdgeInsets.only(bottom: 5.h),
          child: Text(name, style: bodyText100(primaryNeutral500),textAlign: TextAlign.justify,),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.star_rounded, color: Color(0xFFFCD240),),
            Text("$rating", style: headline300(primaryNeutral500), textAlign: TextAlign.justify,),
            Text(" ($reviews)", style: bodyText10(primaryNeutral300),)
        ],),
        Text("\$$price",style: headline300(primaryNeutral500),)
      ],
    );
  }
}
