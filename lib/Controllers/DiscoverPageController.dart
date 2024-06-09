
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:shoesly/Models/Brand.dart';
import 'package:shoesly/Models/ProductColor.dart';
import 'package:shoesly/Models/Review.dart';

import '../Models/Product.dart';

class DiscoverPageController extends ChangeNotifier{
  List<Product> products = [];
  bool isLoading = false;

  getProducts(){
    isLoading = true;
    notifyListeners();
    DatabaseReference starCountRef =
    FirebaseDatabase.instance.ref('products');
    starCountRef.onValue.listen((DatabaseEvent event) {
      Map<String, dynamic> data = jsonDecode(jsonEncode(event.snapshot.value));
      data.forEach((key,value){
        products.add(Product(
            name: value['name'],
            images: value['image'],
            price: double.parse(value['price'].toString()),
            reviews: List<Review>.from(value['reviews'].map((reviewVal) => Review(
                createdOn: reviewVal['createdOn'],
                rating: double.parse(reviewVal['rating'].toString()),
                review: reviewVal['review'],
                userImage: reviewVal['userImage'],
                userName: reviewVal['userName']))),
            brand: Brand(value['brand']['name'], value['brand']['image']),
            description: value['description'],
            sizes: value['sizes'],
            gender: value['gender'],
            colors: List<ProductColor>.from(value['colors'].map((colorVal) => ProductColor(
                name: colorVal['name'],
                color: colorVal['color'])))
        )
        );
      });
      isLoading = false;
      notifyListeners();
    });
  }
}