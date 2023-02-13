
class Address {
  String? location;
  String? country;
  String? state;
  String? city;
  String? zipcode;
  String? countryCode;

  Address(
      {this.location,
      this.country,
      this.state,
      this.city,
      this.zipcode,
      this.countryCode});

  Address.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    zipcode = json['zipcode'];
    countryCode = json['countryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location'] = location;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['zipcode'] = zipcode;
    data['countryCode'] = countryCode;
    return data;
  }
}
