import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoesly/AppConstants.dart';
import 'package:shoesly/Components/ProductListTile.dart';
import 'package:shoesly/Components/TitleAppbar.dart';

import '../Components/PrimaryButton.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryNeutral0,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: primaryNeutral0,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55.h),
            child: TitleAppbar(text: Text("Cart", style: headline400(primaryNeutral500),),),
          ),
          body: Column(
            children: [
              ...List.generate(2,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.h),
                    child: Dismissible(
                        direction: DismissDirection.endToStart,
                        key: UniqueKey(),
                        background: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 88.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                color: primaryError500,
                                borderRadius:
                                BorderRadius.only(
                                  topLeft:
                                  Radius.circular(
                                      25.r),
                                  topRight:
                                  Radius.circular(
                                      0.r),
                                  bottomLeft:
                                  Radius.circular(
                                      25.r),
                                  bottomRight:
                                  Radius.circular(
                                      0.r),
                                ),
                              ),
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 28.w),
                              child: Icon(
                                Icons.delete,
                                color: primaryNeutral0,
                              ),
                            ),
                          ],
                        ),
                        child: ProductListTile()),
                  )
              )
            ],
          ),
          bottomNavigationBar: Container(
            height: 90.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("price", style: bodyText100(primaryNeutral300),),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Text("\$705.00", style: headline600(primaryNeutral500),),
                    ),
                  ],
                ),
                InkWell(
                    child: PrimaryButton(
                      text: "CHECK OUT",
                      onTap: (){
                      },
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}