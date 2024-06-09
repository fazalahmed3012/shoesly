class Review{
  Review({
    required this.createdOn,
    required this.rating,
    required this.review,
    required this.userImage,
    required this.userName
  });

  String userName;
  String userImage;
  double rating;
  String review;
  String createdOn;
}