import 'package:http_example/model/photo.dart';

class PhotoList {
  List<Photo> photos;

  PhotoList({
    this.photos,
  });

  factory PhotoList.fromJson(List<dynamic> json){
    List<Photo> datas = new List<Photo>();
    datas = json.map((value)=>Photo.fromJson(value)).toList();
    return PhotoList(photos: datas);
  }
}
