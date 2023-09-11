import 'package:foodguru/app_values/export.dart';

class TableModel {
  int? id;
  int? tableId;
  int? outletId;
  int? isAvailable;
  int? seatSize;
  int? matchCount;
  RxBool? isSelected = false.obs;


  TableModel(
      {this.id, this.tableId, this.outletId, this.isAvailable, this.seatSize,this.isSelected,this.matchCount});

  TableModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tableId = json['table_id'];
    outletId = json['outlet_id'];
    isAvailable = json['is_available'];
    seatSize = json['seat_size'];
    matchCount = json['match_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['table_id'] = this.tableId;
    data['outlet_id'] = this.outletId;
    data['is_available'] = this.isAvailable;
    data['seat_size'] = this.seatSize;
    data['match_count'] = this.matchCount;
    return data;
  }
}
