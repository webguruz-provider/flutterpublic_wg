

import '../../data/database/databse_values.dart';

class PointsModel {
  int? id;
  int? points;
  int? userId;
  String? createdOn;

  PointsModel({
    this.id,
    this.points,
    this.userId,
    this.createdOn,
  });

  PointsModel.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseValues.columnId];
    points = map[DatabaseValues.columnPoints];
    userId = map[DatabaseValues.columnUserId];
    createdOn = map[DatabaseValues.createdOn];
  }
  PointsModel.fromJson(Map<String, dynamic> map) {
    id = map[DatabaseValues.columnId];
    points = map[DatabaseValues.columnPoints];
    userId = map[DatabaseValues.columnUserId];
    createdOn = map[DatabaseValues.createdOn];

  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      DatabaseValues.columnId: id,
      DatabaseValues.columnPoints: points,
      DatabaseValues.columnUserId: userId,
      DatabaseValues.createdOn: createdOn,
    };
    return map;
  }


  Map<String, Object?> toJson() {
    var map = <String, Object?>{
      DatabaseValues.columnId: id,
      DatabaseValues.columnPoints: points,
      DatabaseValues.columnUserId: userId,
      DatabaseValues.createdOn: createdOn,
    };
    return map;
  }
}