class UserCompany {
  String name;
  String catchPhrase;
  String bs;

  UserCompany({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  factory UserCompany.fromJson(Map<String, dynamic> json){
    return UserCompany(
      name: json["name"],
      catchPhrase: json["catchPhrase"],
      bs: json["bs"],
    );
  }
}
