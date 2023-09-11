import 'package:foodguru/app_values/export.dart';

class OrderDataSendModel {
  var outletId;
  var couponId;
  var addressId;
  var itemTotal;
  var cookingInstructions;
  var paymentId;
  var gst;
  var discount;
  var userId;
  var deliveryCharges;
  double? grandTotal;
  var stateId;
  var orderType;
  var fromTime;
  var toTime;
  var tableId;
  var numberOfPersons;
  var cancelReasonId;

  OrderDataSendModel(
      {this.outletId,
      this.couponId,
      this.discount,
      this.cookingInstructions,
      this.userId,
      this.deliveryCharges,
      this.paymentId,
      this.numberOfPersons,
      this.itemTotal,
      this.grandTotal,
      this.fromTime,
      this.toTime,
      this.tableId,
      this.addressId,
      this.orderType,
      this.cancelReasonId,
      this.stateId,
      this.gst});


  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();
    data[DatabaseValues.columnOutletId]=this.outletId;
    data[DatabaseValues.columnCouponId]=this.couponId;
    data[DatabaseValues.columnDiscount]=this.discount;
    data[DatabaseValues.columnDeliveryCharges]=this.deliveryCharges;
    data[DatabaseValues.columnItemTotal]=this.itemTotal;
    data[DatabaseValues.columnPaymentId]=this.paymentId;
    data[DatabaseValues.columnCookingInstructions]=this.cookingInstructions;
    data[DatabaseValues.columnUserId]=this.userId;
    data[DatabaseValues.columnGrandTotal]=this.grandTotal;
    data[DatabaseValues.ColumnNumberOfPersons]=this.numberOfPersons;
    data[DatabaseValues.columnStateId]=this.stateId;
    data[DatabaseValues.columnAddressId]=this.addressId;
    data[DatabaseValues.columnGst]=this.gst;
    data[DatabaseValues.columnFromTime]=this.fromTime;
    data[DatabaseValues.columnToTime]=this.toTime;
    data[DatabaseValues.columnTableId]=this.tableId;
    data[DatabaseValues.columnCancelReasonId]=this.cancelReasonId;
    data[DatabaseValues.columnOrderType]=this.orderType;
    return data;
  }
}

class OrderItemDataSendModel{
  int? orderId;
  int? itemId;
  int? price;
  int? quantity;
  OrderItemDataSendModel({this.orderId,this.itemId,this.price,this.quantity});
}

