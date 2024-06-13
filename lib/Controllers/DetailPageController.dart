import 'package:flutter/cupertino.dart';
import 'package:shoesly/Models/Review.dart';

class DetailPageController extends ChangeNotifier{
  bool isLoading = false;

  double getRating(List<Review> reviews){
    double totalRating = 0.0;
    for(int i=0; i<reviews.length; i++){
      totalRating += reviews[i].rating;
    }
    return totalRating/reviews.length;
  }

  String getTimeDifference(DateTime createdOn){
    var difference = DateTime.now().difference(createdOn);
    return difference.inHours < 24
        ? "Today"
        : difference.inHours < 48
        ? "Yesterday"
        : "${difference.inDays} days ago";
  }
}