import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoesly/AppConstants.dart';
import 'package:shoesly/Components/Filters.dart';
import 'package:shoesly/Components/IconLeftButton.dart';
import 'package:shoesly/Components/ProductGridTile.dart';
import 'package:shoesly/Controllers/CartController.dart';
import 'package:shoesly/Models/Brand.dart';

import '../Controllers/DiscoverPageController.dart';
import '../Models/Review.dart';
import 'Cart.dart';
import 'ProductDetail.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
    scrollController.addListener (() {
      double maxscroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = MediaQuery
          .of(context)
          .size
          .width * 0.20;
      if (maxscroll - currentScroll <= delta) {
        if(!context.read<DiscoverPageController>().isUpdating) {
          context.read<DiscoverPageController>().updateProducts();
        }
      }
    }) ;
    // TODO: implement initState
    super.initState();
  }

  getData(){
    context.read<DiscoverPageController>().getProducts();
    context.read<DiscoverPageController>().getBrands();
  }

  double getRating(List<Review> reviews){
    double totalRating = 0.0;
    for(int i=0; i<reviews.length; i++){
      totalRating += reviews[i].rating;
    }
    return totalRating/reviews.length;
  }

  /// Firebase Database
  FirebaseDatabase database = FirebaseDatabase.instance;
  final firebaseApp = Firebase.app();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseApp secondaryApp = Firebase.app();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryNeutral0,
      child: SafeArea(
        child: Consumer<DiscoverPageController>(
          builder: (context, productsValue, child) {
            return Scaffold(
              backgroundColor: primaryNeutral0,

              body: Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: Column(
                      children: [

                        /// Title and Cart
                        Padding(
                          padding: EdgeInsets.only(top: 30.h, left: 30.w, right: 30.w, bottom: 24.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Discover", style: headline900(primaryNeutral500),textAlign: TextAlign.justify,),
                              Padding(
                                padding: EdgeInsets.only(top: 11.h),
                                child: InkWell(
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
                                ),
                              )
                            ],
                          ),
                        ),

                        /// Brands
                        productsValue.brandLoading
                            ? LinearProgressIndicator(color: primaryNeutral500,)
                            : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [

                              ...List.generate(
                                  productsValue.brands.length,
                                      (index) => InkWell(
                                    onTap: (){
                                      context.read<DiscoverPageController>().setBrand(productsValue.brands[index]);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                                      child: Text(
                                        productsValue.brands[index].name,
                                        style: headline600(
                                            productsValue.brands[index].name.contains(productsValue.selectedBrand.name??"")
                                                ? primaryNeutral500
                                                : primaryNeutral300),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  )
                              )
                            ],
                          ),
                        ),

                        /// Product Grid
                        productsValue.isLoading
                            ? Expanded(child: Center(child: CircularProgressIndicator(color: primaryNeutral500,),))
                            : productsValue.isError
                            ? Expanded(
                            child: Center(
                                child: Text(
                                    "Something went wrong\ntry again later",
                                    textAlign: TextAlign.center,
                                    style: headline500(primaryNeutral500,)
                                )
                            ))
                            : productsValue.products.isNotEmpty
                            ? Expanded(
                          // height: 1.h,
                          child: GridView(
                            controller: scrollController,
                            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 15.w,
                                mainAxisSpacing: 30.h,
                                childAspectRatio: 150.w / 224.h,
                                crossAxisCount: 2
                              ),
                            children: productsValue.products.where(
                                    (item)=>item.brand.name.contains(productsValue.selectedBrand.name)
                                        || productsValue.selectedBrand.name.contains("All")
                            ).map((product)=>InkWell(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetail(product: product,)));
                              },
                              child: ProductGridTile(
                                name: product.name,
                                images: product.images[0],
                                price: product.price,
                                reviews: product.reviews.length,
                                brand: product.brand,
                                rating: context.read<DiscoverPageController>().getRating(product.reviews),
                              ),
                            )).toList(),
                          ),
                        )
                            : Expanded(
                            child: Center(
                              child: Text(productsValue.products.isEmpty
                                  && productsValue.brands.isEmpty
                                  ? "Something went wrong\ntry again later"
                                  : "No product found",
                                style: headline500(primaryNeutral500), textAlign: TextAlign.center,),)),
                        if(productsValue.isUpdating)
                          Center(child: CircularProgressIndicator(color: primaryNeutral500,),)
                      ],
                    ),
              ),

              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

              floatingActionButton: productsValue.brands.isNotEmpty
                || productsValue.products.isNotEmpty
                ? IconLeftButton(
                onTap: () {
                  showModalBottomSheet(
                    barrierColor: primaryNeutral0,
                    backgroundColor: primaryNeutral0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r)
                    ),
                    useSafeArea: true,
                    isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Filters();
                      });
                },
                text: "Filter",
                icon: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.asset(
                      "assets/icons/filter.png",
                      color: Colors.white,
                      height: 20.h,
                    ),
                    if(productsValue.filterApplied)
                    CircleAvatar(
                      radius: 4.sp,
                      backgroundColor: primaryError500,
                    )
                  ],
                ),
              )
                : Container(),
            );
          }
        ),
      ),
    );
  }
}
