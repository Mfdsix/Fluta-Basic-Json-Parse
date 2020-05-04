class AddressGeo {
  String lat;
  String lng;

  AddressGeo({
    this.lat,
    this.lng,
  });

  factory AddressGeo.fromJson(Map<String, dynamic> json){
    return AddressGeo(
      lat: json["lat"],
      lng: json["lng"],
    );
  }
}
