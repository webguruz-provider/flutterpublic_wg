class RecentSearchesModel {
  int? id;
  int? userId;
  String? title;
  String? createdOn;

  RecentSearchesModel({this.id, this.userId, this.title, this.createdOn});

  RecentSearchesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['created_on'] = this.createdOn;
    return data;
  }
}
