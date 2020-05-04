import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class JsonParseExample extends StatefulWidget {
  @override
  _JsonParseExampleState createState() => _JsonParseExampleState();
}

class _JsonParseExampleState extends State<JsonParseExample> {
  Future data;

  @override
  void initState() {
    data = getData();
    super.initState();
  }

  Future getData() async {
    final url = "https://jsonplaceholder.typicode.com/posts";
    Network network = Network(url);

    var returnedData = network.fetchData();
    return returnedData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Json Parse"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade300,
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: FutureBuilder(
          future: getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return createListView(context, snapshot.data);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget createListView(BuildContext context, List data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index){
        return Card(
            child: ListTile(
              contentPadding: EdgeInsets.all(10.0),
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(data[index]['id'].toString()),
              ),
              title: Text(data[index]['title']),
              subtitle: Text(data[index]['body']),
            ),
        );
      },
      );
  }
}

class Network {
  final String url;

  Network(this.url);

  Future fetchData() async {
    Response response = await get(Uri.encodeFull(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
