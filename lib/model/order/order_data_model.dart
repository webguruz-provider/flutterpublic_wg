import 'package:foodguru/app_values/export.dart';

class OrderDataModel {
  var id;
  var outletId;
  var couponId;
  var addressId;
  var itemTotal;
  var gst;
  var stateId;
  var discount;
  var paymentId;
  List<OrderItemDataModel>? orderItemList;
  var deliveryCharges;
  var userId;
  var cookingInstructions;
  double? grandTotal;
  var createdOn;
  var address;
  var addressLongitude;
  var addressLatitude;
  var outletLongitude;
  var outletLatitude;
  var orderType;
  var tableId;
  var numberOfPersons;
  var fromTime;
  var toTime;

  OrderDataModel(
      {this.id,
        this.outletId,
        this.couponId,
        this.addressId,
        this.itemTotal,
        this.gst,
        this.stateId,
        this.discount,
        this.paymentId,
        this.deliveryCharges,
        this.orderItemList,
        this.userId,
        this.cookingInstructions,
        this.grandTotal,
        this.createdOn,
        this.address,
        this.addressLongitude,
        this.addressLatitude,
        this.outletLongitude,
        this.outletLatitude,
        this.orderType,
        this.tableId,
        this.numberOfPersons,
        this.fromTime,
        this.toTime,
      });

  OrderDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    outletId = json['outlet_id'];
    couponId = json['coupon_id'];
    addressId = json['address_id'];
    itemTotal = json['item_total'];
    gst = json['gst'];
    stateId = json['state_id'];
    discount = json['discount'];
    paymentId = json['payment_id'];
    deliveryCharges = json['delivery_charges'];
    userId = json['user_id'];
    cookingInstructions = json['cooking_instructions'];
    grandTotal = json['grand_total'];
    createdOn = json['created_on'];
    address = json['address'];
    addressLongitude = json['address_longitude'];
    addressLatitude = json['address_latitude'];
    outletLongitude = json['outlet_longitude'];
    outletLatitude = json['outlet_latitude'];
    orderType = json['order_type'];
    tableId = json['table_id'];
    numberOfPersons = json['number_of_persons'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['outlet_id'] = this.outletId;
    data['coupon_id'] = this.couponId;
    data['address_id'] = this.addressId;
    data['item_total'] = this.itemTotal;
    data['gst'] = this.gst;
    data['state_id'] = this.stateId;
    data['discount'] = this.discount;
    data['payment_id'] = this.paymentId;
    data['delivery_charges'] = this.deliveryCharges;
    data['user_id'] = this.userId;
    data['cooking_instructions'] = this.cookingInstructions;
    data['grand_total'] = this.grandTotal;
    data['created_on'] = this.createdOn;
    data['address'] = this.address;
    data['address_longitude'] = this.addressLongitude;
    data['address_latitude'] = this.addressLatitude;
    data['outlet_longitude'] = this.outletLongitude;
    data['outlet_latitude'] = this.outletLatitude;
    data['order_type'] = this.orderType;
    data['table_id'] = this.tableId;
    data['number_of_persons'] = this.numberOfPersons;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    return data;
  }
}
