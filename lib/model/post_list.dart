import 'package:http_example/model/post.dart';

class PostList {
  List<Post> posts;

  PostList({
    this.posts,
  });

  factory PostList.fromJson(List<dynamic> json){
    List<Post> datas = new List<Post>();
    datas = json.map((value)=>Post.fromJson(value)).toList();
    return PostList(posts: datas);
  }
}
