import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_example/model/album.dart';
import 'package:http_example/model/album_list.dart';
import 'package:http_example/model/photo.dart';
import 'package:http_example/model/photo_list.dart';
import 'package:http_example/util/network.dart';

class UserAlbum extends StatefulWidget {
  final int userId;

  const UserAlbum({Key key, this.userId}) : super(key: key);
  @override
  _UserAlbumState createState() => _UserAlbumState(userId);
}

class _UserAlbumState extends State<UserAlbum> {
  final int userId;

  Future<AlbumList> getUserAlbums() async {
    String url = "https://jsonplaceholder.typicode.com/users/$userId/albums";
    var returnedData = await Network.fetchDatas(url);
    return AlbumList.fromJson(json.decode(returnedData));
  }

  Future<PhotoList> getAlbumPhotos(int albumId) async {
    String url = "https://jsonplaceholder.typicode.com/albums/$albumId/photos";
    var returnedData = await Network.fetchDatas(url);
    return PhotoList.fromJson(json.decode(returnedData));
  }

  _UserAlbumState(this.userId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Albums"),
      ),
      backgroundColor: Colors.grey.shade300,
      body: Container(
        padding: EdgeInsets.all(5),
        child: FutureBuilder(
            future: getUserAlbums(),
            builder: (context, AsyncSnapshot<AlbumList> snapshot) {
              if (snapshot.hasData) {
                return drawUserAlbums(context, snapshot.data.albums);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Widget drawUserAlbums(BuildContext context, List<Album> data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data[index].title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FutureBuilder(
                        future: getAlbumPhotos(data[index].id),
                        builder: (context, AsyncSnapshot<PhotoList> snapshot) {
                          if (snapshot.hasData) {
                            return drawAlbumPhotos(
                                context, snapshot.data.photos);
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget drawAlbumPhotos(BuildContext context, List<Photo> photos) {
    return Container(
      height: 150,
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(width: 8.0),
              scrollDirection: Axis.horizontal,
          itemCount: photos.length,
          itemBuilder: (context, index) {
            return Card(
                          child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(photos[index].thumbnailUrl ??
                              "data:image/png;base64,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"),
                          fit: BoxFit.cover)),
                ),
              ),
            );
          }),
    );
  }
}
