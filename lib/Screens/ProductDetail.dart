import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoesly/AppConstants.dart';
import 'package:shoesly/Components/PrimaryButton.dart';
import 'package:shoesly/Components/ReviewCard.dart';
import 'package:shoesly/Components/RightIconAppbar.dart';
import 'package:shoesly/Components/SecondaryButton.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int quantity = 1;
  TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    quantityController.text = "$quantity";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryNeutral0,
      child: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(55.h),
              child: RightIconAppbar(icon: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.asset(
                    "assets/icons/cart.png",
                    height: 24.h,
                  ),
                  CircleAvatar(
                    radius: 4.sp,
                    backgroundColor: primaryError500,
                  )
                ],
              ),),
            ),
            backgroundColor: primaryNeutral0,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
              
                    /// Image Slider and color selector
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 31.5.w),
                            width: 315.w,
                            height: 315.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.r),
                              color: primaryNeutral500.withOpacity(0.05),
                            ),
                            child: Image.asset("assets/0.png")
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10.h, right: 10.w),
                            height: 40.h,
                            // width: 132.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.r),
                              color: primaryNeutral0,
                            ),
                            child: Wrap(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 10.h),
                                  child: Container(
                                    width: 20.sp,
                                    height: 20.sp,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: primaryNeutral0,
                                      border: Border.all(
                                        color: primaryNeutral200
                                      )
                                    ),
                                    ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 10.h),
                                  child:  Container(
                                    width: 20.sp,
                                    height: 20.sp,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: primaryNeutral500,
                                        border: Border.all(
                                            color: primaryNeutral200
                                        )
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 10.h),
                                  child:  Container(
                                    width: 20.sp,
                                    height: 20.sp,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.teal,
                                        border: Border.all(
                                            color: primaryNeutral200
                                        )
                                    ),
                                    child: Icon(Icons.check, color: Colors.white,size: 9.sp,),
                                  )
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 10.h),
                                  child:  Container(
                                    width: 20.sp,
                                    height: 20.sp,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blueAccent,
                                        border: Border.all(
                                            color: primaryNeutral200
                                        )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
              
                    /// Product Name
                    Padding(
                      padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
                      child: Text("Jordan 1 Retro High Tie Dye", style: headline600(primaryNeutral500),),
                    ),
              
                    /// Rating
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: 4.5,
                            itemSize: 10.sp,
                            itemBuilder: (context, index) => Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                            ),
                        ),
              
                        Text(" 4.5", style: headline300(primaryNeutral500),),
                        Text(" (1045 Reviews)", style: bodyText10(primaryNeutral300),),
                      ],
                    ),
              
                    /// Sizes
                    Padding(
                      padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
                      child: Text("Size", style: headline400(primaryNeutral500),),
                    ),
              
                    Row(
                      children: [
                        Container(
                          width: 40.sp,
                          height: 40.sp,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: primaryNeutral200
                            )
                          ),
                          alignment: Alignment.center,
                          child: Text("39", style: headline300(primaryNeutral400),),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15..w),
                          child: Container(
                            width: 40.sp,
                            height: 40.sp,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                    color: primaryNeutral200
                                )
                            ),
                            alignment: Alignment.center,
                            child: Text("39.5", style: headline300(primaryNeutral400),),
                          ),
                        ),
                        Container(
                          width: 40.sp,
                          height: 40.sp,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                  color: primaryNeutral200
                              )
                          ),
                          alignment: Alignment.center,
                          child: Text("40", style: headline300(primaryNeutral400),),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15..w),
                          child: Container(
                            width: 40.sp,
                            height: 40.sp,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                    color: primaryNeutral200
                                )
                            ),
                            alignment: Alignment.center,
                            child: Text("40.5", style: headline300(primaryNeutral400),),
                          ),
                        ),
                        Container(
                          width: 40.sp,
                          height: 40.sp,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                              border: Border.all(
                                  color: primaryNeutral200
                              )
                          ),
                          alignment: Alignment.center,
                          child: Text("41", style: headline300(primaryNeutral0),),
                        )
                      ],
                    ),
              
                    /// Description
                    Padding(
                      padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
                      child: Text("Description", style: headline400(primaryNeutral500),),
                    ),
              
                    Text("Engineered to crush any movement-based workout, these On sneakers enhance the label's original Cloud sneaker with cutting edge technologies for a pair. ",
                    style: bodyText200(primaryNeutral400),),
              
                    /// Reviews
                    Padding(
                      padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
                      child: Text("Reviews", style: headline400(primaryNeutral500),),
                    ),

                    ...List.generate(3, (index) => Padding(
                      padding: EdgeInsets.only(top: index!=0?30.h:0),
                      child: ReviewCard(),
                    )
                        ),

                    /// See All Review Button
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: SecondaryButton(text: "See All Reviews"),
                    )
                  ],
                ),
              ),
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
                        child: Text("\$235.00", style: headline600(primaryNeutral500),),
                      ),
                    ],
                  ),
                  InkWell(
                      child: PrimaryButton(
                        text: "ADD TO CART",
                        onTap: (){
                          showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: primaryNeutral0,
                              context: context,
                              builder: (contex){
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return Padding(
                                      padding: MediaQuery.of(context).viewInsets,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
                                        child: Wrap(
                                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [

                                            /// Title and close button
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Add to cart", style: headline600(primaryNeutral500),),
                                                InkWell(
                                                  onTap: (){
                                                    Navigator.pop(context);
                                                  },
                                                    child: Icon(Icons.close, size: 18.sp,)
                                                )
                                              ],
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
                                              child: Text("Quantity",style: headline300(primaryNeutral500),),
                                            ),

                                            /// Quantity selector
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none
                                                    ),
                                                    keyboardType: TextInputType.number,
                                                    onChanged: (val){
                                                      quantity = int.parse(val);
                                                    },
                                                    controller: quantityController,
                                                    style: bodyText200(primaryNeutral500),
                                                  ),
                                                ),

                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(right: 22.w),
                                                      child: InkWell(
                                                        onTap: (){
                                                          if(quantity>1){
                                                            quantity--;
                                                            setState((){
                                                              quantityController.text = "$quantity";
                                                            });
                                                          }
                                                        },
                                                        child: Icon(
                                                          CupertinoIcons.minus_circle,
                                                          size: 24.sp,
                                                          color: quantity>1?primaryNeutral500:primaryNeutral300,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        quantity++;
                                                        setState(() {
                                                          quantityController.text = "$quantity";
                                                        });
                                                      },
                                                        child: Icon(CupertinoIcons.add_circled, size: 24.sp,)
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(top: 20.h, bottom: 30.h),
                                              child: Divider(color: primaryNeutral500,),
                                            ),

                                            /// Add to cart
                                            Container(
                                              height: 57.h,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("price", style: bodyText100(primaryNeutral300),),
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 5.h),
                                                        child: Text("\$235.00", style: headline600(primaryNeutral500),),
                                                      ),
                                                    ],
                                                  ),
                                                  InkWell(
                                                      child: PrimaryButton(
                                                        text: "ADD TO CART",
                                                        onTap: (){
                                                          Navigator.pop(context);
                                                          showModalBottomSheet(
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
                                                                          
                                                                          Text("Added to cart", style: headline700(primaryNeutral500),),
                                                                          
                                                                          Padding(
                                                                            padding: EdgeInsets.only(top: 5.h, bottom: 20.h),
                                                                            child: Text("$quantity ${quantity>1?"Items":"Item"} Total"),
                                                                          ),
                                                                          
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              SecondaryButton(text: "BACK EXPLORE"),
                                                                              PrimaryButton(text: "TO CART", onTap: (){})
                                                                          ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                });
                                                              }
                                                          );
                                                        },
                                                      )
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                );
                              }
                          );
                        },
                      )
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
