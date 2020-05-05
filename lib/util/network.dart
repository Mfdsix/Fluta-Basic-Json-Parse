import 'package:http/http.dart';

class Network{

  static Future<String> fetchDatas(String url) async{
    print("Fetching data from : $url");
    Response response = await get(Uri.encodeFull(url));

    if(response.statusCode == 200){
      // print(response.body);
      return response.body;
    }else{
      // print(response.statusCode);
      return "[]";
    }
  }

  static Future<String> fetchData(String url) async{
    print("Fetching data from : $url");
    Response response = await get(Uri.encodeFull(url));

    if(response.statusCode == 200){
      return response.body;
    }else{
      return null;
    }
  }

}