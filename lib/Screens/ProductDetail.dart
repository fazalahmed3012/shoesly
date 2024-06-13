import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoesly/AppConstants.dart';
import 'package:shoesly/Components/PrimaryButton.dart';
import 'package:shoesly/Components/ReviewCard.dart';
import 'package:shoesly/Components/RightIconAppbar.dart';
import 'package:shoesly/Components/SecondaryButton.dart';
import 'package:shoesly/Controllers/CartController.dart';
import 'package:shoesly/Controllers/DetailPageController.dart';
import 'package:shoesly/Screens/Reviews.dart';

import '../Models/Product.dart';
import 'Cart.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({super.key, required this.product});

  Product product;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int quantity = 1;
  TextEditingController quantityController = TextEditingController();
  int _current = 0;
  final CarouselController _controller = CarouselController();
  int selectedSizeIndex = 0;
  int selectedColorIndex = 0;
  int indexExist = -1;

  @override
  void initState() {
    // TODO: implement initState
    indexExist = context.read<CartController>().products.indexWhere((itm) => itm.name == widget.product.name);
    if(indexExist > -1)
      {
        quantity = context.read<CartController>().productQuantity[indexExist];
      }
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
              child: RightIconAppbar(
                icon: InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Cart()));
                  },
                  child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.asset(
                      "assets/icons/cart.png",
                      height: 24.h,
                    ),
                    if(context.watch<CartController>().products.isNotEmpty)
                    CircleAvatar(
                      radius: 4.sp,
                      backgroundColor: primaryError500,
                    )
                  ],
                                ),
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
                        /// Image slider
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 31.5.w),
                            width: 315.w,
                            height: 315.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.r),
                              color: primaryNeutral500.withOpacity(0.05),
                            ),
                            child: CarouselSlider(
                              carouselController: _controller,
                              options: CarouselOptions(
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                },
                                viewportFraction: 1,
                                autoPlay: false,
                              ),
                              items: List.generate(
                                  widget.product.images.length,
                                      (index) => CachedNetworkImage(
                                    imageUrl: widget.product.images[index],
                                    // width: 315.w,
                                    // height: 315.h,
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
                            )
                        ),

                        /// Dot indicator
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: widget.product.images.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () => _controller.animateToPage(entry.key),
                                child: Container(
                                  width: 7.sp,
                                  height: 7.sp,
                                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness == Brightness.dark
                                          ? Colors.white
                                          : Colors.black)
                                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        /// Color Selector
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
                              children: List.generate(
                                  widget.product.colors.length,
                                      (index) => Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 10.h),
                                    child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          selectedColorIndex = index;
                                        });
                                      },
                                      child: Container(
                                        width: 20.sp,
                                        height: 20.sp,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(widget.product.colors[index].color),
                                            border: Border.all(
                                                color: selectedColorIndex == index
                                                    ? primaryNeutral200
                                                    : Colors.transparent
                                            )
                                        ),
                                        child: selectedColorIndex == index
                                            ? Icon(Icons.check, color: primaryNeutral200,size: 9.sp,)
                                            : Container(),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
              
                    /// Product Name
                    Padding(
                      padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
                      child: Text(widget.product.name, style: headline600(primaryNeutral500),),
                    ),
              
                    /// Rating
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: context.read<DetailPageController>().getRating(widget.product.reviews),
                            itemSize: 10.sp,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                            ),
                        ),
              
                        Text(" ${context.read<DetailPageController>().getRating(widget.product.reviews)}", style: headline300(primaryNeutral500),),
                        Text(" (${widget.product.reviews.length})", style: bodyText10(primaryNeutral300),),
                      ],
                    ),
              
                    /// Sizes
                    Padding(
                      padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
                      child: Text("Size", style: headline400(primaryNeutral500),),
                    ),
              
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            widget.product.sizes.length,
                                (index) => Padding(
                              padding: EdgeInsets.only(left: index != 0?7.5.w:0, right: 7.5.w),
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    selectedSizeIndex = index;
                                  });
                                },
                                child: Container(
                                  width: 40.sp,
                                  height: 40.sp,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: index == selectedSizeIndex
                                          ? primaryNeutral500
                                          : primaryNeutral0,
                                      border: Border.all(
                                          color: primaryNeutral200
                                      )
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    widget.product.sizes[index].toString(),
                                    style: headline300(
                                        index == selectedSizeIndex
                                            ? primaryNeutral0
                                            : primaryNeutral400
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ),
                      ),
                    ),
              
                    /// Description
                    Padding(
                      padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
                      child: Text("Description", style: headline400(primaryNeutral500),),
                    ),
              
                    Text(widget.product.description,
                    style: bodyText200(primaryNeutral400),),
              
                    /// Reviews
                    Padding(
                      padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
                      child: Text("Reviews", style: headline400(primaryNeutral500),),
                    ),

                    ...List.generate(
                        widget.product.reviews.length>3
                            ? 3
                            : widget.product.reviews.length,
                            (index) => Padding(
                      padding: EdgeInsets.only(top: index!=0?30.h:0),
                      child: ReviewCard(review: widget.product.reviews[index],),
                    )
                    ),

                    /// See All Review Button
                    if(widget.product.reviews.length > 3)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: SecondaryButton(
                        text: "See All Reviews",
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ReviewsPage(reviews: widget.product.reviews,)));
                        },
                      ),
                    )
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
                      Text("price", style: bodyText100(primaryNeutral300),),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text("\$${widget.product.price}", style: headline600(primaryNeutral500),),
                      ),
                    ],
                  ),
                  PrimaryButton(
                    text: context.watch<CartController>().checkInCart(widget.product)? "UPDATE CART" : "ADD TO CART",
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
                                                decoration: const InputDecoration(
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
                                                    child: Text("\$${widget.product.price * quantity}", style: headline600(primaryNeutral500),),
                                                  ),
                                                ],
                                              ),
                                              PrimaryButton(
                                                text: context.watch<CartController>().checkInCart(widget.product) ? "UPDATE CART" : "ADD TO CART",
                                                onTap: (){
                                                  Product finalProduct = Product(
                                                      name: widget.product.name,
                                                      images: widget.product.images,
                                                      price: widget.product.price,
                                                      reviews: widget.product.reviews,
                                                      brand: widget.product.brand,
                                                      description: widget.product.description,
                                                      sizes: [widget.product.sizes[selectedSizeIndex]],
                                                      gender: widget.product.gender,
                                                      colors: [widget.product.colors[selectedColorIndex]]);
                                                  if(context.read<CartController>().checkInCart(finalProduct)) {
                                                    context.read<CartController>().removeFromCart(finalProduct);
                                                  }
                                                  context.read<CartController>().addToCart(finalProduct, quantity);
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
                                                                      SecondaryButton(
                                                                        text: "BACK EXPLORE",
                                                                        onTap: (){
                                                                          Navigator.pop(context);
                                                                          Navigator.pop(context);
                                                                        },
                                                                      ),
                                                                      PrimaryButton(
                                                                          text: "TO CART",
                                                                          onTap: (){
                                                                            Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                    builder: (context) =>
                                                                                        Cart()));
                                                                          }
                                                                          )
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
                ],
              ),
            ),
          )
      ),
    );
  }
}
