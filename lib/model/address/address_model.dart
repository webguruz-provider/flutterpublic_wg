class AddressModel {
  int? id;
  int? userId;
  String? address;
  String? city;
  String? state;
  String? country;
  String? pinCode;
  double? latitude;
  double? longitude;
  int? addressType;
  int? isManualAddress;

  AddressModel(
      {this.id,
        this.userId,
        this.address,
        this.city,
        this.state,
        this.country,
        this.pinCode,
        this.latitude,
        this.longitude,
        this.isManualAddress,
        this.addressType});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pinCode = json['pin_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    addressType = json['address_type'];
    isManualAddress = json['is_manual_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pin_code'] = this.pinCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address_type'] = this.addressType;
    data['is_manual_address'] = this.isManualAddress;
    return data;
  }
}
