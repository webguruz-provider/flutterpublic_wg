import 'package:foodguru/app_values/export.dart';


class RestaurantItemDataModel {
  var id;
  var outletId;
  var restaurantId;
  var restaurantName;
  var logo;
  var description;
  List<RestaurantImagesDataModel>? images;
  List<TableModel>? tableList;
  var categoryId;
  var outlet;
  var languageId;
  double? averageRating;
  var phone;
  var city;
  var state;
  var country;
  var latitude;
  var longitude;
  var freeDeliveryAbove;
  var isDineInAvailable;

  RestaurantItemDataModel(
      {this.id,
        this.outletId,
        this.restaurantId,
        this.restaurantName,
        this.logo,
        this.description,
        this.outlet,
        this.tableList,
        this.images,
        this.languageId,
        this.averageRating,
        this.phone,
        this.categoryId,
        this.city,
        this.state,
        this.country,
        this.latitude,
        this.longitude,
        this.freeDeliveryAbove,
        this.isDineInAvailable});

  RestaurantItemDataModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    outletId = json['outlet_id'];
    restaurantId = json['restaurant_id'];
    restaurantName = json['restaurant_name'];
    logo = json['logo'];
    description = json['description'];
    categoryId = json['category_id'];
    outlet = json['outlet'];
    languageId = json['language_id'];
    averageRating = json['average_rating'];
    phone = json['phone'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    freeDeliveryAbove = json['free_delivery_above'];
    isDineInAvailable = json['is_dine_in_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['outlet_id'] = this.outletId;
    data['restaurant_id'] = this.restaurantId;
    data['restaurant_name'] = this.restaurantName;
    data['logo'] = this.logo;
    data['description'] = this.description;
    data['outlet'] = this.outlet;
    data['category_id'] = this.categoryId;
    data['language_id'] = this.languageId;
    data['average_rating'] = this.averageRating;
    data['phone'] = this.phone;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['free_delivery_above'] = this.freeDeliveryAbove;
    data['is_dine_in_available'] = this.isDineInAvailable;
    return data;
  }
}


