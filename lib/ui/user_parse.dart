import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_example/model/user.dart';
import 'package:http_example/model/user_list.dart';
import 'package:http_example/util/network.dart';

class UserParse extends StatefulWidget {
  @override
  _UserParseState createState() => _UserParseState();
}

class _UserParseState extends State<UserParse> {

  Future<UserList> users;

  @override
  void initState() {
    super.initState();
    users = getUsers();
  }
  
  Future<UserList> getUsers() async {
    String url = "https://jsonplaceholder.typicode.com/users";
    var returnedData = await Network.fetchDatas(url);
    return UserList.fromJson(json.decode(returnedData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Available Users"),
        ),
        backgroundColor: Colors.grey.shade300,
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.green,
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.only(bottom: 5.0),
                child: Text("Special Thanks to https://jsonplaceholder.typicode.com"),
              ),
              Expanded(
                child: FutureBuilder(
                  future: users,
                  builder: (context, AsyncSnapshot<UserList> snapshot) {
                    if (snapshot.hasData) {
                      return createListView(context, snapshot.data.users);
                      // return Text(snapshot.data.users.toString());
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget createListView(BuildContext context, List<User> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(data[index].id.toString()),
            ),
            title: Text(data[index].username),
            subtitle: Text(data[index].email),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => debugPrint("hai"),
          ),
        );
      },
    );
  }
}