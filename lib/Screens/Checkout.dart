import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoesly/AppConstants.dart';
import 'package:shoesly/Components/TitleAppbar.dart';
import 'package:shoesly/Controllers/CartController.dart';
import 'package:shoesly/Models/Product.dart';
import 'package:shoesly/Screens/Discover.dart';

import '../Components/PrimaryButton.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> products = context.read<CartController>().products;

    return Container(
      color: primaryNeutral0,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: primaryNeutral0,
          
          appBar: PreferredSize(
              preferredSize: Size( 1.sw,55.h),
              child: TitleAppbar(text: Text("Order Summary", style: headline400(primaryNeutral500),),)
          ),

          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
              child: Wrap(
                children: [
                  Text("Information", style: headline500(primaryNeutral500),),
            
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Payment Method", style: headline300(primaryNeutral500),),
                            Padding(
                              padding: EdgeInsets.only(top: 5.h),
                              child: Text("Credit Card", style: bodyText200(primaryNeutral400),),
                            ),
            
                          ],
                        ),
            
                        Icon(Icons.arrow_forward_ios_rounded, color: primaryNeutral400,)
                      ],
                    ),
                  ),
            
                  Divider(color: primaryNeutral200,),
            
                  Padding(
                    padding: EdgeInsets.only(top: 20.h, bottom: 30.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Location", style: headline300(primaryNeutral500),),
                            Padding(
                              padding: EdgeInsets.only(top: 5.h),
                              child: Text("Semarang, Indonesia", style: bodyText200(primaryNeutral400),),
                            ),
                          ],
                        ),
            
                        Icon(Icons.arrow_forward_ios_rounded, color: primaryNeutral400,)
                      ],
                    ),
                  ),
                  
                  Text("Order Detail", style: headline500(primaryNeutral500),),
            
                  ...List.generate(
                      products.length,
                      (index){
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(products[index].name, style: headline400(primaryNeutral500),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${products[index].brand.name} "
                                      ". ${products[index].colors[0].name} "
                                      ". ${products[index].sizes[0]} "
                                      ". Qty ${context.read<CartController>().productQuantity[index]}",
                                    style: bodyText200(primaryNeutral400),),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: Text("\$${products[index].price}", style: headline500(primaryNeutral500),),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      }
                  ),
                  
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                    child: Text("Payment Detail", style: headline500(primaryNeutral500),),
                  ),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("Sub Total", style: bodyText200(primaryNeutral400),),
                    Text("\$${context.read<CartController>().totalAmount}", style: headline400(primaryNeutral500),),
                  ],),
            
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Voucher", style: bodyText200(primaryNeutral400),),
                        Text("\$0", style: headline400(primaryNeutral500),),
                      ],),
                  ),
            
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Shipping", style: bodyText200(primaryNeutral400),),
                        Text("\$20.0", style: headline400(primaryNeutral500),),
                      ],),
                  ),
            
                  Divider(color: primaryNeutral200,),
            
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Order", style: bodyText200(primaryNeutral400),),
                        Text("\$${context.read<CartController>().totalAmount + 20.0}", style: headline400(primaryNeutral500),),
                      ],),
                  ),
                ],
              ),
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
                    Text("Grand Total", style: bodyText100(primaryNeutral300),),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Text("\$${context.read<CartController>().totalAmount + 20.0}", style: headline600(primaryNeutral500),),
                    ),
                  ],
                ),
                InkWell(
                    child: PrimaryButton(
                      text: "PAYMENT",
                      onTap: () async {
                        context.read<CartController>().placeOrder();
                        await FirebaseAnalytics.instance
                            .logBeginCheckout(
                            value: context.read<CartController>().totalAmount + 20.0,
                            currency: 'USD',
                            items: [
                              ...List.generate(
                                  context.read<CartController>().products.length,
                                  (index) => AnalyticsEventItem(
                                      itemName: context.read<CartController>().products[index].name,
                                      itemBrand: context.read<CartController>().products[index].brand.name,
                                      price: context.read<CartController>().products[index].price,
                                      quantity: context.read<CartController>().productQuantity[index]
                                  )
                              ),
                            ],
                        );
                        showModalBottomSheet(
                          isDismissible: false,
                            backgroundColor: primaryNeutral0,
                            context: context,
                            builder: (context){
                              return StatefulBuilder(builder: (context,setState){
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [

                                        /// Success Icon
                                        Container(
                                            margin: EdgeInsets.only(bottom: 20.h),
                                            width: 100.sp,
                                            height: 100.sp,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: primaryNeutral500
                                                )
                                            ),
                                            child: Icon(
                                              Icons.check,
                                              size: 35.5.sp,
                                              color: primaryNeutral300,
                                            )
                                        ),

                                        Text("Order placed successfully", style: headline700(primaryNeutral500),),

                                        Padding(
                                          padding: EdgeInsets.only(top: 5.h, bottom: 20.h),
                                          child: Text("Grand Total of \$${context.read<CartController>().totalAmount + 20.0} paid"),
                                        ),

                                        PrimaryButton(
                                            text: "CONTINUE EXPLORING",
                                            onTap: (){
                                              context.read<CartController>().clearCart();
                                              Navigator.of(context).popUntil((route) => route.isFirst);
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => DiscoverPage()));
                                            }
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                            }
                        );
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             Checkout()));
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
