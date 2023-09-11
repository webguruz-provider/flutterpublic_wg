import 'package:foodguru/app_values/export.dart';

class RestaurantMainModel {
  var restaurantId;
  var restaurantName;
  var outlet;

  RestaurantMainModel({
    this.restaurantName,
    this.restaurantId,
    this.outlet,
  });

  RestaurantMainModel.fromMap(Map<String, dynamic> map) {
    restaurantId = map[DatabaseValues.columnRestaurantId];
    restaurantName = map[DatabaseValues.columnRestaurantName];
    outlet = map[DatabaseValues.columnOutlet];
  }

  RestaurantMainModel.fromJson(Map<String, dynamic> map) {
    restaurantId = map[DatabaseValues.columnRestaurantId];
    restaurantName = map[DatabaseValues.columnRestaurantName];
    outlet = map[DatabaseValues.columnOutlet];
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      DatabaseValues.columnRestaurantId: restaurantId,
      DatabaseValues.columnRestaurantName: restaurantName,
      DatabaseValues.columnOutlet: outlet,
    };
    return map;
  }
}
