import 'package:http_example/model/album.dart';

class AlbumList {
  List<Album> albums;

  AlbumList({
    this.albums,
  });

  factory AlbumList.fromJson(List<dynamic> json){
    List<Album> datas = new List<Album>();
    datas = json.map((value)=>Album.fromJson(value)).toList();
    return AlbumList(albums: datas);
  }
}
