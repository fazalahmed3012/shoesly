import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoesly/AppConstants.dart';
import 'package:shoesly/Components/ProductListTile.dart';
import 'package:shoesly/Components/TitleAppbar.dart';
import 'package:shoesly/Controllers/CartController.dart';
import 'package:shoesly/Screens/Checkout.dart';

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
        child: Consumer<CartController>(
          builder: (context, cartValue, child) {
            return Scaffold(
              backgroundColor: primaryNeutral0,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(55.h),
                child: TitleAppbar(text: Text("Cart", style: headline400(primaryNeutral500),),),
              ),
              body: cartValue.products.isEmpty 
                  ? Center(child: Text("Cart is empty", style: headline700(primaryNeutral500),),)
                  : Column(
                children: List.generate(cartValue.products.length,
                        (index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: Dismissible(
                        onDismissed: (direction){
                          cartValue.removeFromCart(cartValue.products[index]);
                        },
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
                          child: ProductListTile(
                            product: cartValue.products[index],
                            quantity: cartValue.productQuantity[index],
                            index: index,)),
                    )
                ),
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: primaryNeutral100,
                      blurRadius: 5.sp,
                      spreadRadius: 5.sp,
                      blurStyle: BlurStyle.outer
                    )
                  ]
                ),
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
                          child: Text("\$${cartValue.totalAmount}", style: headline600(primaryNeutral500),),
                        ),
                      ],
                    ),
                    InkWell(
                        child: PrimaryButton(
                          text: "CHECK OUT",
                          onTap: (){
                            if(cartValue.products.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Checkout()));
                            }
                          },
                        )
                    )
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}