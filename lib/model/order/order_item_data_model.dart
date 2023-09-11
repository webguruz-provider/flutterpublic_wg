import 'package:foodguru/app_values/export.dart';

class OrderItemDataModel {
  var id;
  var itemId;
  var itemName;
  var outletId;
  var categoryId;
  var description;
  var outlet;
  var itemPrice;
  var discountedPrice;
  var pointsPerQuantity;
  var isVeg;
  List<ItemImagesDataModel>? images;
  double?averageRating;
  double? ratingGiven=0.0;
  var languageId;
  var createdOn;
  var restaurantName;
  var quantity;
  var orderPrice;
  var orderId;
  RxInt? isFavourite=0.obs;


  OrderItemDataModel(
      {this.id,
        this.itemId,
        this.itemName,
        this.outletId,
        this.categoryId,
        this.images,
        this.description,
        this.itemPrice,
        this.ratingGiven=0.0,
        this.discountedPrice,
        this.outlet,
        this.pointsPerQuantity,
        this.isVeg,
        this.averageRating,
        this.languageId,
        this.createdOn,
        this.restaurantName,
        this.quantity,
        this.orderPrice,
        this.isFavourite,
        this.orderId});

  OrderItemDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    itemName = json['item_name'];
    outletId = json['outlet_id'];
    categoryId = json['category_id'];
    description = json['description'];
    itemPrice = json['item_price'];
    discountedPrice = json['discounted_price'];
    pointsPerQuantity = json['points_per_quantity'];
    isVeg = json['is_veg'];
    averageRating = json['average_rating'];
    languageId = json['language_id'];
    createdOn = json['created_on'];
    restaurantName = json['restaurant_name'];
    isFavourite?.value = json['is_favourite'];
    quantity = json['quantity'];
    orderPrice = json['order_price'];
    orderId = json['order_id'];
    outlet = json['outlet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['item_name'] = this.itemName;
    data['outlet_id'] = this.outletId;
    data['category_id'] = this.categoryId;
    data['description'] = this.description;
    data['item_price'] = this.itemPrice;
    data['discounted_price'] = this.discountedPrice;
    data['points_per_quantity'] = this.pointsPerQuantity;
    data['is_veg'] = this.isVeg;
    data['average_rating'] = this.averageRating;
    data['language_id'] = this.languageId;
    data['created_on'] = this.createdOn;
    data['is_favourite'] = this.isFavourite;
    data['restaurant_name'] = this.restaurantName;
    data['quantity'] = this.quantity;
    data['order_price'] = this.orderPrice;
    data['order_id'] = this.orderId;
    data['outlet'] = this.outlet;
    return data;
  }
}
