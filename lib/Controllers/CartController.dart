import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Models/Product.dart';

class CartController extends ChangeNotifier{
  bool isLoading = false;
  List<Product> products = [];
  List<int> productQuantity = [];
  double totalAmount = 0;

  bool checkInCart(Product product){
    int index = -1;
    index = products.indexWhere((item) => item.name == product.name);
    return index==-1
        ? false
        : true;
  }

  clearCart(){
    products = [];
    productQuantity = [];
    totalAmount = 0;
    notifyListeners();
  }

  addToCart(Product product, int quantity){
    products.add(product);
    productQuantity.add(quantity);
    totalAmount += product.price * quantity;
    notifyListeners();
  }

  removeFromCart(Product product){
    int index = products.indexWhere((item) => item.name == product.name);
    totalAmount -= product.price * productQuantity[index];
    products.removeAt(index);
    productQuantity.removeAt(index);
    notifyListeners();
  }

  increaseQuantity(int index){
    totalAmount -= products[index].price * productQuantity[index];
    productQuantity[index]++;
    totalAmount += products[index].price * productQuantity[index];
    notifyListeners();
  }

  decreaseQuantity(int index){
    totalAmount -= products[index].price * productQuantity[index];
    productQuantity[index]--;
    totalAmount += products[index].price * productQuantity[index];
    notifyListeners();
  }

  placeOrder() async {
    CollectionReference orders = FirebaseFirestore.instance.collection('orders');
    await orders.add({
      "items" : [
        ...List.generate(products.length, (index) => {
          "name" : products[index].name,
          "brand" : products[index].brand.name,
          "color" : products[index].colors[0].name,
          "size" : products[index].sizes[0],
          "quantity" : productQuantity[index],
          "price" : products[index].price
        })
      ],
      "voucher" : 0,
      "shipping" : 20,
      "paymentMethod" : "Credit Card",
      "location" : "Semarang, indonesia",
      "totalAmount" : totalAmount+20
    });
  }

}