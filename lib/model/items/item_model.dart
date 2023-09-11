import 'package:foodguru/app_values/export.dart';

class ItemModel {
  var id;
  var itemId;
  var itemName;
  var outletId;
  var categoryId;
  var description;
  var itemPrice;
  var isVeg;
  var discountedPrice;
  var pointsPerQuantity;
  List<NutritionModel>? nutritionList;
  List<ItemImagesDataModel>? images;
  double? averageRating;
  var languageId;
  var createdOn;
  var restaurantName;
  var outlet;
  var isSeasonalSpecial;
  var restaurantId;
  var gstPercentage;
  var deliveryPerKm;
  var outletRating;
  var phone;
  var latitude;
  var longitude;
  var couponId;
  var freeDeliveryAbove;
  var isDineInAvailable;
  RxInt? isFavourite=0.obs;
  RxBool? isAddedToCart=false.obs;
  RxInt? quantity=0.obs;

  ItemModel(
      {this.id,
        this.itemId,
        this.images,
        this.itemName,
        this.outletId,
        this.categoryId,
        this.description,
        this.nutritionList,
        this.couponId,
        this.itemPrice,
        this.isSeasonalSpecial,
        this.discountedPrice,
        this.pointsPerQuantity,
        this.gstPercentage,
        this.deliveryPerKm,
        this.averageRating,
        this.languageId,
        this.createdOn,
        this.isVeg,
        this.restaurantName,
        this.outlet,
        this.restaurantId,
        this.outletRating,
        this.phone,
        this.latitude,
        this.longitude,
        this.freeDeliveryAbove,
        this.isDineInAvailable,
        this.isFavourite,
        this.quantity,
        this.isAddedToCart
      });


  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    itemName = json['item_name'];
    isVeg = json['is_veg'];
    outletId = json['outlet_id'];
    categoryId = json['category_id'];
    isSeasonalSpecial = json['is_seasonal_special'];
    description = json['description'];
    itemPrice = json['item_price'];
    discountedPrice = json['discounted_price'];
    pointsPerQuantity = json['points_per_quantity'];
    averageRating = json['average_rating'];
    languageId = json['language_id'];
    createdOn = json['created_on'];
    restaurantName = json['restaurant_name'];
    outlet = json['outlet'];
    quantity?.value = json['quantity']??0;
    restaurantId = json['restaurant_id'];
    gstPercentage = json['gst_percentage'];
    deliveryPerKm = json['delivery_per_km'];
    outletRating = json['outlet_rating'];
    phone = json['phone'];
    isFavourite?.value = json['is_favourite'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    couponId = json['coupon_id'];
    freeDeliveryAbove = json['free_delivery_above'];
    isDineInAvailable = json['is_dine_in_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['item_name'] = this.itemName;
    data['outlet_id'] = this.outletId;
    data['is_veg'] = this.isVeg;
    data['category_id'] = this.categoryId;
    data['description'] = this.description;
    data['is_seasonal_special'] = this.isSeasonalSpecial;
    data['item_price'] = this.itemPrice;
    data['discounted_price'] = this.discountedPrice;
    data['points_per_quantity'] = this.pointsPerQuantity;
    data['average_rating'] = this.averageRating;
    data['language_id'] = this.languageId;
    data['quantity'] = this.quantity??0;
    data['created_on'] = this.createdOn;
    data['restaurant_name'] = this.restaurantName;
    data['outlet'] = this.outlet;
    data['gst_percentage'] = this.gstPercentage;
    data['coupon_id'] = this.couponId;
    data['delivery_per_km'] = this.deliveryPerKm;
    data['restaurant_id'] = this.restaurantId;
    data['outlet_rating'] = this.outletRating;
    data['phone'] = this.phone;
    data['is_favourite'] = this.isFavourite;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['free_delivery_above'] = this.freeDeliveryAbove;
    data['is_dine_in_available'] = this.isDineInAvailable;
    return data;
  }
}
