import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoesly/AppConstants.dart';
import 'package:shoesly/Components/IconLeftButton.dart';
import 'package:shoesly/Components/ProductGridTile.dart';
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
  List<Brand> brands = [
    Brand("All", "image"),
    Brand("Nike", "assets/brands/nike.png"),
    Brand("Jordan", "assets/brands/jordan.png"),
    Brand("Adidas", "assets/brands/adidas.png"),
    Brand("Rebook", "assets/brands/reebok.png"),
    Brand("Puma", "assets/brands/puma.png"),
    Brand("vans", "assets/brands/vans.png"),
  ];

  late Brand selectedBrand = Brand("All", "image");

  @override
  void initState() {
    Brand selectedBrand = brands[0];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
    // TODO: implement initState
    super.initState();
  }

  getData(){
    context.read<DiscoverPageController>().getProducts();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryNeutral0,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: primaryNeutral0,

          body: Consumer<DiscoverPageController>(
            builder: (context, productsValue, child) {
              return Column(
                children: [

                  /// Title and Cart
                  Padding(
                    padding: EdgeInsets.only(top: 30.h, left: 30.w, right: 30.w, bottom: 24.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap:() async {

                            context.read<DiscoverPageController>().getProducts();
                            // final rtdb = FirebaseDatabase.instanceFor(app: firebaseApp, databaseURL: 'https://shoesly-219de-default-rtdb.firebaseio.com/');
                            // DatabaseReference ref = FirebaseDatabase.instance.ref("products/${DateTime.now().microsecondsSinceEpoch.toString()}");
                            // await ref.set({
                            //   "name": "Jordan 1 Retro High Tie Dye",
                            //   "price": 275,
                            //   "gender": "Woman",
                            //   "brand" : {
                            //     "name" : "Puma",
                            //     "image" : "https://firebasestorage.googleapis.com/v0/b/shoesly-219de.appspot.com/o/brands%2Fpuma.png?alt=media&token=9b2a9fea-ba4c-49f4-8d52-cbfcea374248",
                            //   },
                            //   "description": "Engineered to crush any movement-based workout, these On sneakers enhance the label's original Cloud sneaker with cutting edge technologies for a pair.",
                            //   "reviews" :[
                            //     {
                            //       "userName": "Nolan Carder",
                            //       "userImage": "https://firebasestorage.googleapis.com/v0/b/shoesly-219de.appspot.com/o/reviewers%2Fp1.png?alt=media&token=6aa600e2-d7ae-4499-9633-bbd04e82175d",
                            //       "rating": 5,
                            //       "review": "Perfect for keeping your feet dry and warm in damp conditions.",
                            //       "createdOn": DateTime.now().toString()
                            //     },
                            //     {
                            //       "userName": "Maria Saris",
                            //       "userImage": "https://firebasestorage.googleapis.com/v0/b/shoesly-219de.appspot.com/o/reviewers%2Fp2.png?alt=media&token=5ccdb697-8494-463f-9921-be9abd331362",
                            //       "rating": 4,
                            //       "review": "Perfect for keeping your feet dry and warm in damp conditions.",
                            //       "createdOn": DateTime.now().toString()
                            //     },
                            //     {
                            //       "userName": "Gretchen Septimus",
                            //       "userImage": "https://firebasestorage.googleapis.com/v0/b/shoesly-219de.appspot.com/o/reviewers%2Fp3.png?alt=media&token=790e3a2e-fa91-4a01-85f7-50ffdcc68f7d",
                            //       "rating": 5,
                            //       "review": "Perfect for keeping your feet dry and warm in damp conditions.",
                            //       "createdOn": DateTime.now().toString()
                            //     },
                            //     {
                            //       "userName": "Roger Stanton",
                            //       "userImage": "https://firebasestorage.googleapis.com/v0/b/shoesly-219de.appspot.com/o/reviewers%2Fp4.png?alt=media&token=276f87cd-88b7-4236-9e4a-1fb89026fdde",
                            //       "rating": 4,
                            //       "review": "Perfect for keeping your feet dry and warm in damp conditions.",
                            //       "createdOn": DateTime.now().toString()
                            //     },
                            //     {
                            //       "userName": "Hanna Levin",
                            //       "userImage": "https://firebasestorage.googleapis.com/v0/b/shoesly-219de.appspot.com/o/reviewers%2Fp5.png?alt=media&token=f6793f03-c085-4467-9a32-399d7c294d99",
                            //       "rating": 5,
                            //       "review": "Perfect for keeping your feet dry and warm in damp conditions.",
                            //       "createdOn": DateTime.now().toString()
                            //     }
                            //
                            //   ],
                            //   "image": [
                            //     "https://firebasestorage.googleapis.com/v0/b/shoesly-219de.appspot.com/o/4.png?alt=media&token=7b3fab0a-7c47-4cb7-b294-73e7632d92f2",
                            //     "https://firebasestorage.googleapis.com/v0/b/shoesly-219de.appspot.com/o/41.png?alt=media&token=7f43d3fe-a2ae-418c-8141-047725597abe",
                            //     "https://firebasestorage.googleapis.com/v0/b/shoesly-219de.appspot.com/o/42.png?alt=media&token=15ae76b5-f729-4937-9644-aaef43ecce2c"
                            //   ],
                            //   "colors": [
                            //     // {
                            //     //   "color": 0xFFFF4C5E,
                            //     //   "name": "Red"
                            //     // }
                            //     {
                            //       "color": 0xFFE7E7E7,
                            //       "name": "White"
                            //     },
                            //     // {
                            //     //   "color": 0xFF101010,
                            //     //   "name": "Black"
                            //     // },
                            //     // {
                            //     //   "color": 0xFF648B8B,
                            //     //   "name": "Green"
                            //     // },
                            //     // {
                            //     //   "color": 0xFF2952CC,
                            //     //   "name": "Blue"
                            //     // }
                            //   ],
                            //   "sizes": [
                            //     38, 39, 40, 41, 42,
                            //   ]
                            // }).catchError((error){log("error : $error");});
                          },
                            child: Text("Discover", style: headline900(primaryNeutral500),textAlign: TextAlign.justify,)),
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          brands.length,
                          (index) => InkWell(
                            onTap: (){
                              setState(() {
                                selectedBrand = brands[index];
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                              child: Text(
                                brands[index].name,
                                style: headline600(brands[index].name.contains(selectedBrand.name)?primaryNeutral500:primaryNeutral300),textAlign: TextAlign.justify,
                              ),
                            ),
                          )
                      ),
                    ),
                  ),

                  /// Product Grid
                  productsValue.products.isNotEmpty
                      ? Expanded(
                    // height: 1.h,
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 15.w,
                          mainAxisSpacing: 30.h,
                          childAspectRatio: 150.w / 224.h,
                          crossAxisCount: 2
                        ),
                      itemCount: productsValue.products.length,
                      itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetail()));
                            },
                            child: ProductGridTile(
                              name: productsValue.products[index].name,
                              images: productsValue.products[index].images[0],
                              price: productsValue.products[index].price,
                              reviews: productsValue.products[index].reviews.length,
                              brand: productsValue.products[index].brand,
                              rating: getRating(productsValue.products[index].reviews),
                            ),
                          );
                      },
                    ),
                  )
                      : Expanded(child: Center(child: Text("No product found", style: headline500(primaryNeutral500),),)),

                ],
              );
            }
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: IconLeftButton(
            text: "Filter",
            icon: Stack(
              alignment: Alignment.topRight,
              children: [
                Image.asset(
                  "assets/icons/filter.png",
                  color: Colors.white,
                  height: 20.h,
                ),
                CircleAvatar(
                  radius: 4.sp,
                  backgroundColor: primaryError500,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
