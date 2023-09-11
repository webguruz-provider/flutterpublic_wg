import 'package:foodguru/app_values/export.dart';

class RestaurantImagesDataModel {
  var id;
  var outletId;
  var imageUrl;
  var createdOn;


  RestaurantImagesDataModel(
      {this.id,
        this.outletId,
        this.imageUrl,
        this.createdOn,
     });

  RestaurantImagesDataModel.fromJson(Map<String, dynamic> json) {
    id = json[DatabaseValues.columnId];
    outletId = json[DatabaseValues.columnOutletId];
    imageUrl = json[DatabaseValues.columnImageUrl];
    createdOn = json[DatabaseValues.createdOn];

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[DatabaseValues.columnId] = this.id;
    data[DatabaseValues.columnOutletId] = this.outletId;
    data[DatabaseValues.columnImageUrl] = this.imageUrl;
    data[DatabaseValues.createdOn] = this.createdOn;
    return data;
  }
}