import 'package:foodguru/app_values/export.dart';

class ItemImagesDataModel {
  var id;
  var itemId;
  var imageUrl;
  var createdOn;


  ItemImagesDataModel(
      {this.id,
        this.itemId,
        this.imageUrl,
        this.createdOn,
      });

  ItemImagesDataModel.fromJson(Map<String, dynamic> json) {
    id = json[DatabaseValues.columnId];
    itemId = json[DatabaseValues.columnItemId];
    imageUrl = json[DatabaseValues.columnImageUrl];
    createdOn = json[DatabaseValues.createdOn];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[DatabaseValues.columnId] = this.id;
    data[DatabaseValues.columnItemId] = this.itemId;
    data[DatabaseValues.columnImageUrl] = this.imageUrl;
    data[DatabaseValues.createdOn] = this.createdOn;
    return data;
  }
}