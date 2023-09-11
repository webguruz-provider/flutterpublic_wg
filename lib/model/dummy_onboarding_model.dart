class OnBoardingModel {
  List<Items>? items;

  OnBoardingModel({this.items});

  OnBoardingModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add( Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? title;
  String? images;
  String? subtitle;
  String? id;

  Items({this.title, this.images, this.subtitle, this.id});

  Items.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    images = json['images'];
    subtitle = json['subtitle'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['images'] = images;
    data['subtitle'] = subtitle;
    data['id'] = id;
    return data;
  }
}
