import 'package:foodguru/app_values/export.dart';

class MenuItemDataModel {
  String? imageUrl;
  String? restaurantName;
  String? dishName;
  String? description;
  String? itemPrice;
  String? discountedPrice;
  String? pointsPerQuantity;
  int? distance;
  String? rating;
  bool? isVeg;
  RxBool isFavourite;
  RxBool isAddedToCart;
  RxDouble ratingAdded;
  RxInt quantity;

  MenuItemDataModel({
    this.restaurantName,
    this.imageUrl,
    this.rating,
    this.pointsPerQuantity,
    this.itemPrice,
    this.distance,
    this.dishName,
    this.discountedPrice,
    this.description,
    bool isFavourite = false,
    double ratingAdded = 1.0,
    this.isVeg,
    bool isAddedToCart = false,
    int quantity = 0,
  })  : isFavourite = RxBool(isFavourite),
        isAddedToCart = RxBool(isAddedToCart),
        ratingAdded = RxDouble(ratingAdded),
        quantity = RxInt(quantity);
}
