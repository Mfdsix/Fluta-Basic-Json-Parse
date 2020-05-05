import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_example/model/post.dart';
import 'package:http_example/model/post_list.dart';
import 'package:http_example/util/network.dart';

class UserPost extends StatefulWidget {
  final int userId;

  const UserPost({Key key, this.userId}) : super(key: key);
  @override
  _UserPostState createState() => _UserPostState(userId);
}

class _UserPostState extends State<UserPost> {
  final int userId;
  Future<PostList> userPosts;

  _UserPostState(this.userId);

  Future<PostList> getUserPosts() async {
    String url = "https://jsonplaceholder.typicode.com/users/$userId/posts";
    var returnedData = await Network.fetchDatas(url);
    print(returnedData);
    return PostList.fromJson(json.decode(returnedData));
  }

  @override
  void initState() {
    userPosts = getUserPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Posts"),
      ),
      backgroundColor: Colors.grey.shade300,
      body: Container(
        child: FutureBuilder(
            future: userPosts,
            builder: (context, AsyncSnapshot<PostList> snapshot) {
              if (snapshot.hasData) {
                return drawPostList(context, snapshot.data.posts);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Widget drawPostList(BuildContext context,List<Post> data) {
    return Container(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index){
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,
                    child: Text(data[index].id.toString(), style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),),
                  ),
                  SizedBox(height: 20,),
                  Text(data[index].title, style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),),
                  SizedBox(height: 10,),
                  Text(data[index].body, style: TextStyle(
                    color: Colors.black45,
                    fontSize: 16,
                  ),),
                ],
              ),
            ),
          );
        },
        ),
    );
  }
}
