import 'package:shoesly/Models/ProductColor.dart';

import 'Brand.dart';
import 'Review.dart';

class Product{
  Product({
    required this.name,
    required this.images,
    required this.price,
    required this.reviews,
    required this.brand,
    required this.description,
    required this.sizes,
    required this.gender,
    required this.colors
  });

  String name;
  String gender;
  String description;
  List<Review> reviews;
  List<dynamic> images;
  List<dynamic> sizes;
  List<ProductColor> colors;
  double price;
  Brand brand;
}