import 'package:http_example/model/address_geo.dart';

class UserAddress {
  String street;
  String suite;
  String city;
  String zipcode;
  AddressGeo geo;

  UserAddress({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json){
    return UserAddress(
      street: json["street"],
      suite: json["suite"],
      city: json["city"],
      zipcode: json["zipcode"],
      geo: AddressGeo.fromJson(json["geo"]),
    );
  }
}
