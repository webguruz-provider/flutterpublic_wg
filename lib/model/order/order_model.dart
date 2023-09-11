import 'package:foodguru/app_values/export.dart';

class OrderModel{
  int? orderNo;
  int? amount;
  int? state_id;
  List<MenuItemDataModel>? menuList;
  var orderPlacedOn;
  OrderModel({this.amount,this.orderNo,this.orderPlacedOn,this.menuList,this.state_id});
}