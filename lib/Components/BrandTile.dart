import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoesly/AppConstants.dart';

import '../Models/Brand.dart';

class BrandTile extends StatelessWidget {
  BrandTile({super.key, required this.brand, required this.isSelected, required this.count});

  Brand brand;
  int count;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72.w,
      height: 97.h,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: EdgeInsets.all(13.sp),
                margin: EdgeInsets.only(bottom: 10.h),
                width: 50.sp,
                height: 50.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryNeutral100
                ),
                child: CachedNetworkImage(
                  color: primaryNeutral500,
                  imageUrl: brand.image,
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
              ),
              if(isSelected)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Icon(Icons.check_circle, size: 20.sp,),
              )
            ],
          ),
          
          Text(brand.name, style: headline300(primaryNeutral500),),
          Text("$count Items", style: bodyText10(primaryNeutral300),)
        ],
      ),
    );
  }
}
