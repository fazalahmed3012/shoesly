import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoesly/AppConstants.dart';
import 'package:shoesly/Controllers/CartController.dart';
import 'package:shoesly/Screens/Cart.dart';

import '../Models/Product.dart';

class ProductListTile extends StatelessWidget {
  ProductListTile({super.key, required this.product, required this.quantity, required this.index});

  Product product;
  int quantity;
  int index;

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
              child: CachedNetworkImage(
                imageUrl: product.images[0],
                width: 70.w,
                // height: 85.h,
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
              )
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name, style: headline400(primaryNeutral500),),
              Padding(
                padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
                child: Text("${product.brand.name} . ${product.colors[0].name} . ${product.sizes[0]}", style: bodyText100(primaryNeutral400),),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 30.w),
                    width: 110.w,
                      child: Text("\$${product.price * quantity}", style: headline300(primaryNeutral500),)
                  ),

                  InkWell(
                    onTap: (){
                      if(quantity > 1) {
                        context.read<CartController>().decreaseQuantity(index);
                      }
                    },
                      child: Icon(
                        CupertinoIcons.minus_circle,
                        size: 20.sp,
                        color: quantity > 1 ? primaryNeutral500 : primaryNeutral300,
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text("$quantity", style: headline300(primaryNeutral500),),
                  ),
                  InkWell(
                    onTap: (){
                      context.read<CartController>().increaseQuantity(index);
                    },
                      child: Icon(CupertinoIcons.add_circled, size: 20.sp,)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
