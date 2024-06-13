
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoesly/Models/Brand.dart';
import 'package:shoesly/Models/ProductColor.dart';
import 'package:shoesly/Models/Review.dart';
import '../Models/Product.dart';

class DiscoverPageController extends ChangeNotifier{
  List<Product> products = [];
  List<ProductColor> filterColors = [];
  List<String> filterColorNames = [];
  List<Brand> brands = [];
  List<int> brandsCount = [];
  bool isLoading = false;
  bool isUpdating = false;
  bool isError = false;
  bool brandLoading = false;
  bool filterApplied = false;
  Brand selectedBrand = Brand("All", "image");
  double minPrice = 0.0;
  double maxPrice = 500.0;
  String sortBy = "";
  List<String> selectedGender = [];
  List<String> appliedFilters = [];
  List<ProductColor> selectedColor = [];
  List<String> selectedColorName = [];
  late QueryDocumentSnapshot lastVisible;

  clearFilters(){
    selectedBrand = Brand("All", "image");
    minPrice = 0.0;
    maxPrice = 500.0;
    sortBy = "";
    selectedGender = [];
    selectedColor = [];
    selectedColorName = [];
    appliedFilters = [];
    getProducts();
    notifyListeners();
    checkFilter();
  }

  checkFilter(){
    if(selectedBrand.name.contains("All")
        && minPrice == 0.0
        && maxPrice == 500.0
        && sortBy.isEmpty
        && selectedGender.isEmpty
        && selectedColor.isEmpty
    ){
      filterApplied = false;
      notifyListeners();
    }
    else{
      filterApplied = true;
      notifyListeners();
    }
  }

  getProducts(){
    isLoading = true;
    isError = false;
    filterColorNames = [];
    filterColors = [];
    products = [];
    notifyListeners();

    CollectionReference fireProducts = FirebaseFirestore.instance.collection('products');

    var data = fireProducts.orderBy(
        sortBy.isEmpty
            ? "name"
            : sortBy.contains("Lowest")
            ? "price"
            : sortBy.contains("Reviews")
            ? "reviews"
            : sortBy.contains("Most") ?
            "createOn"
            : sortBy.contains("Gender")
            ? "gender"
            : "colors",
        descending: sortBy.contains("Most")
            ? true : false);

    if(selectedGender.isNotEmpty){
      data = data.where(
          "gender",
          whereIn: [...List.generate(selectedGender.length,
                  (index)=>selectedGender[index])]);
    }

    data.limit(5).get()
        .then((QuerySnapshot querySnapshot){
          lastVisible = querySnapshot.docs[querySnapshot.size - 1];
          if(querySnapshot.docs.isNotEmpty) {
            querySnapshot.docs.forEach((value) {
              if(value['price']>=minPrice && value['price']<=maxPrice) {
                if(selectedColor.isEmpty || List<ProductColor>.from(
                    value['colors'].map((colorVal) =>
                        ProductColor(
                            name: colorVal['name'],
                            color: colorVal['color']))).any((item){return selectedColor.any((color){return color.name.contains(item.name);});})) {
                  products.add(Product(
                  name: value['name'],
                  images: value['image'],
                  price: double.parse(value['price'].toString()),
                  reviews: List<Review>.from(value['reviews'].map((reviewVal) =>
                      Review(
                          createdOn: reviewVal['createdOn'],
                          rating: double.parse(reviewVal['rating'].toString()),
                          review: reviewVal['review'],
                          userImage: reviewVal['userImage'],
                          userName: reviewVal['userName']))),
                  brand: Brand(value['brand']['name'], value['brand']['image']),
                  description: value['description'],
                  sizes: value['sizes'],
                  gender: value['gender'],
                  colors: List<ProductColor>.from(
                      value['colors'].map((colorVal) =>
                          ProductColor(
                              name: colorVal['name'],
                              color: colorVal['color'])))
              ));
                }
              }
              List<ProductColor> temp = List<ProductColor>.from(
                  value['colors'].map((colorVal) =>
                      ProductColor(
                          name: colorVal['name'],
                          color: colorVal['color'])));
              for (int i = 0; i < temp.length; i++) {
                if (!filterColors.contains(temp[i]) &&
                    !filterColorNames.contains(temp[i].name)) {
                  filterColors.add(temp[i]);
                  filterColorNames.add(temp[i].name);
                }
              }
              isLoading = false;
              notifyListeners();
            });
          }
          else{
            isLoading = false;
            notifyListeners();
          }
    }).onError((error, trace){
      isLoading = false;
      isError = true;
      notifyListeners();
      log("Error caught : $error");
    });
  }

  updateProducts(){
    isUpdating = true;
    isError = false;
    notifyListeners();

    CollectionReference fireProducts = FirebaseFirestore.instance.collection('products');

    var data = fireProducts.orderBy(
        sortBy.isEmpty
            ? "name"
            : sortBy.contains("Lowest")
            ? "price"
            : sortBy.contains("Reviews")
            ? "reviews"
            : sortBy.contains("Most") ?
        "createOn"
            : sortBy.contains("Gender")
            ? "gender"
            : "colors",
        descending: sortBy.contains("Most")
            ? true : false);

    if(selectedGender.isNotEmpty){
      data = data.where(
          "gender",
          whereIn: [...List.generate(selectedGender.length,
                  (index)=>selectedGender[index])]);
    }

    data.startAfterDocument(lastVisible).limit(5).get()
        .then((QuerySnapshot querySnapshot){
      if(querySnapshot.docs.isNotEmpty) {
        lastVisible = querySnapshot.docs[querySnapshot.size - 1];
        querySnapshot.docs.forEach((value) {
          if(value['price']>=minPrice && value['price']<=maxPrice) {
            if(selectedColor.isEmpty || List<ProductColor>.from(
                value['colors'].map((colorVal) =>
                    ProductColor(
                        name: colorVal['name'],
                        color: colorVal['color']))).any((item){return selectedColor.any((color){return color.name.contains(item.name);});})) {
              products.add(Product(
                  name: value['name'],
                  images: value['image'],
                  price: double.parse(value['price'].toString()),
                  reviews: List<Review>.from(value['reviews'].map((reviewVal) =>
                      Review(
                          createdOn: reviewVal['createdOn'],
                          rating: double.parse(reviewVal['rating'].toString()),
                          review: reviewVal['review'],
                          userImage: reviewVal['userImage'],
                          userName: reviewVal['userName']))),
                  brand: Brand(value['brand']['name'], value['brand']['image']),
                  description: value['description'],
                  sizes: value['sizes'],
                  gender: value['gender'],
                  colors: List<ProductColor>.from(
                      value['colors'].map((colorVal) =>
                          ProductColor(
                              name: colorVal['name'],
                              color: colorVal['color'])))
              ));
            }
          }
          List<ProductColor> temp = List<ProductColor>.from(
              value['colors'].map((colorVal) =>
                  ProductColor(
                      name: colorVal['name'],
                      color: colorVal['color'])));
          for (int i = 0; i < temp.length; i++) {
            if (!filterColors.contains(temp[i]) &&
                !filterColorNames.contains(temp[i].name)) {
              filterColors.add(temp[i]);
              filterColorNames.add(temp[i].name);
            }
          }
          isUpdating = false;
          notifyListeners();
        });
      }
      else{
        isUpdating = false;
        notifyListeners();
      }
    }).onError((error, trace){
      isUpdating = false;
      isError = true;
      notifyListeners();
      log("Error caught : $error");
    });
  }

  getBrands(){
    brandLoading = true;
    notifyListeners();

    CollectionReference fireProducts = FirebaseFirestore.instance.collection('brands');
    fireProducts.get().then((QuerySnapshot querySnapshot){
      if(querySnapshot.docs.isNotEmpty) {
        brands = [Brand("All", "image")];
        querySnapshot.docs.forEach((value) {
          brands.add(Brand(value['name'], value['image']));
        });
      }else{
        brandLoading = false;
        notifyListeners();
      }
    });
    brandLoading = false;
    notifyListeners();
  }

  double getRating(List<Review> reviews){
    double totalRating = 0.0;
    for(int i=0; i<reviews.length; i++){
      totalRating += reviews[i].rating;
    }
    return totalRating/reviews.length;
  }

  setBrand(Brand brand){
    if(!appliedFilters.contains("brand")){
      appliedFilters.add("brand");
    } else if (brand.name == "All"){
      appliedFilters.removeWhere((item) => item == "brand");
    }
    selectedBrand = brand;
    notifyListeners();
    checkFilter();
  }

  setPriceRange(double min, double max){
    if(!appliedFilters.contains("price")){
      appliedFilters.add("price");
    }
    else if(min == 0 && max == 500){
      appliedFilters.removeWhere((item) => item == "price");
    }
    minPrice = min;
    maxPrice = max;
    getProducts();
    checkFilter();
  }

  addGender(String gender){
    if(!appliedFilters.contains("gender")){
      appliedFilters.add("gender");
    }
    sortBy = "Gender";
    selectedGender.add(gender);
    checkFilter();
  }

  removeGender(String gender){
    selectedGender.removeWhere((item) => item == gender);
    if(selectedGender.isEmpty){
      appliedFilters.removeWhere((item) => item == "gender");
    }
    checkFilter();
  }

  addColor(ProductColor color){
    if(!appliedFilters.contains("color")){
      appliedFilters.add("color");
    }
    selectedColor.add(color);
    selectedColorName.add(color.name);
    checkFilter();
  }

  removeColor(ProductColor color){
    selectedColor.removeWhere((item) => item.name == color.name);
    selectedColorName.removeWhere((item) => item == color.name);
    if (selectedColor.isEmpty){
      appliedFilters.removeWhere((item) => item == "color");
    }
    checkFilter();
  }

  setSort(String sort){
    if(sort != "Gender"){
      selectedGender = [];
    }
    if(!appliedFilters.contains("sort")){
      appliedFilters.add("sort");
    } else if (sort.isEmpty){
      appliedFilters.removeWhere((item) => item == "sort");
    }
    sortBy = sort;
    checkFilter();
  }

  getBrandCount() {
    brandsCount = [];
    for (int i = 0; i < brands.length; i++) {
      int temp = 0;
      for (var product in products) {
        if (product.brand.name == brands[i].name) {
          temp++;
        }
      }
      brandsCount.add(temp);
    }
  }
}