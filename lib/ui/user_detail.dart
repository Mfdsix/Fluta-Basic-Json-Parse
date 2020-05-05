import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_example/model/user.dart';
import 'package:http_example/ui/user_album.dart';
import 'package:http_example/ui/user_post.dart';
import 'package:http_example/util/network.dart';

class UserDetail extends StatefulWidget {
  final int userId;

  const UserDetail({Key key, this.userId}) : super(key: key);

  @override
  _UserDetailState createState() => _UserDetailState(userId);
}

class _UserDetailState extends State<UserDetail> {
  final int userId;
  Future<User> user;

  _UserDetailState(this.userId);

  Future<User> getUser() async {
    String url = "https://jsonplaceholder.typicode.com/users/$userId";
    var returnedData = await Network.fetchData(url);
    return User.fromJson(json.decode(returnedData));
  }

  @override
  void initState() {
    user = getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Detail"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 32.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: FutureBuilder(
              future: user,
              builder: (context, AsyncSnapshot<User> snapshot) {
                if (snapshot.hasData) {
                  return createUserDetail(snapshot.data);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget createUserDetail(User data) {
    return Column(
      children: <Widget>[
        drawUserDetailHeader(data),
        drawDivider(),
        drawUserDetailFields(data),
        drawUserAddress(data),
        drawUserCompany(data),
      ],
    );
  }

  Widget drawDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Divider(
        color: Colors.grey.shade300,
        height: 1.0,
      ),
    );
  }

  Widget drawUserDetailHeader(User data) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.blue,
          child: Container(
            width: 150,
            height: 150,
            child: Center(
              child: Text(
                data.name[0],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          data.name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          data.email,
          style: TextStyle(
            color: Colors.black38,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context){
                return UserPost(userId: data.id);
              })),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(5.0)
                ),
                child: Icon(Icons.chat_bubble, size: 20,color: Colors.white),
              ),
            ),
            SizedBox(width: 5.0,),
            InkWell(
              onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context){
                return UserAlbum(userId: data.id);
              })),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5.0)
                ),
                child: Icon(Icons.image, size: 20,color: Colors.white),
              ),
            ),
          ],
        ),
        SizedBox(height: 20,),
      ],
    );
  }

  Widget drawUserDetailFields(User data) {
    return Column(
      children: <Widget>[
        drawUserField(field: "Username", value: data.username),
        drawUserField(field: "Phone", value: data.phone),
        drawUserField(field: "Website", value: data.website),
      ],
    );
  }

  Widget drawUserField({String field, String value}) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: 120,
              child: Text(field),
            ),
            Expanded(
                child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            )),
          ],
        ),
        drawDivider(),
      ],
    );
  }

  Widget drawUserAddress(User data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0,),
          Text("User Address", style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 20.0
          ),),
        SizedBox(height: 20.0,),
        drawUserField(field: "Street", value: data.address.street),
        drawUserField(field: "Suite", value: data.address.suite),
        drawUserField(field: "City", value: data.address.city),
        drawUserField(field: "Zipcode", value: data.address.zipcode),
        drawUserField(field: "Geo", value: "${data.address.geo.lat}, ${data.address.geo.lng}"),
      ],
    );
  }

  Widget drawUserCompany(User data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0,),
          Text("Company", style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 20.0
          ),),
        SizedBox(height: 20.0,),
        drawUserField(field: "Company Name", value: data.company.name),
        drawUserField(field: "Catch Phrase", value: data.company.catchPhrase),
        drawUserField(field: "BS", value: data.company.bs),
      ],
    );
  }
}
