import 'package:foodguru/app_values/export.dart';

class NotificationModel {
  int? id;
  int? notificationId;
  int? userId;
  int? languageId;
  int? notificationType;
  String? title;
  String? description;
  String? createdOn;
  RxBool? isReadMore=false.obs;

  NotificationModel(
      {this.id,
        this.notificationId,
        this.userId,
        this.languageId,
        this.notificationType,
        this.title,
        this.description,
        this.isReadMore,
        this.createdOn,
      });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notificationId = json['notification_id'];
    userId = json['user_id'];
    languageId = json['language_id'];
    notificationType = json['notification_type'];
    title = json['title'];
    description = json['description'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notification_id'] = this.notificationId;
    data['user_id'] = this.userId;
    data['language_id'] = this.languageId;
    data['notification_type'] = this.notificationType;
    data['title'] = this.title;
    data['description'] = this.description;
    data['created_on'] = this.createdOn;
    return data;
  }
}

