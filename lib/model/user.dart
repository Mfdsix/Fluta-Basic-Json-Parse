import 'dart:convert';

import 'package:http_example/model/user_address.dart';
import 'package:http_example/model/user_company.dart';

class User {
  int id;
  String name;
  String username;
  String email;
  String phone;
  String website;
  UserAddress address;
  UserCompany company;

  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.phone,
    this.website,
    this.address,
    this.company,
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"],
      name: json["name"],
      username: json["username"],
      email: json["email"],
      phone: json["phone"],
      website: json["website"],
      address: UserAddress.fromJson(json["address"]),
      company: UserCompany.fromJson(json["company"]),
    );
  }
}
