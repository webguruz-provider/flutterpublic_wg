class CouponModel {
  int? id;
  int? couponId;
  String? couponName;
  String? description;
  String? imageUrl;
  int? minimumOrderValue;
  int? value;
  int? minimumOrder;
  int? maximumDiscount;

  CouponModel(
      {this.id,
        this.couponId,
        this.couponName,
        this.description,
        this.imageUrl,
        this.minimumOrderValue,
        this.value,
        this.minimumOrder,
        this.maximumDiscount});

  CouponModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    couponId = json['coupon_id'];
    couponName = json['coupon_name'];
    description = json['description'];
    imageUrl = json['image_url'];
    minimumOrderValue = json['minimum order value'];
    value = json['value'];
    minimumOrder = json['minimum_order'];
    maximumDiscount = json['maximum_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['coupon_id'] = this.couponId;
    data['coupon_name'] = this.couponName;
    data['description'] = this.description;
    data['image_url'] = this.imageUrl;
    data['minimum order value'] = this.minimumOrderValue;
    data['value'] = this.value;
    data['minimum_order'] = this.minimumOrder;
    data['maximum_discount'] = this.maximumDiscount;
    return data;
  }
}
