import 'package:http_example/model/user.dart';

class UserList {
  List<User> users;

  UserList({
    this.users,
  });
  
  factory UserList.fromJson(List<dynamic> json){
    List<User> datas = new List<User>();
    datas = json.map((value) => User.fromJson(value)).toList();

    return UserList(users: datas);
  }
}
