import 'dart:convert';
import 'package:http/http.dart' as http;



class NetworkHelper{

  NetworkHelper(this.url);
  String url;
  Future getData() async{
    http.Response dateGet  = await http.get(url);
    print(dateGet.statusCode);
    if (dateGet.statusCode == 200) {
      String data = dateGet.body;
      var rawdata = jsonDecode(data);
      return rawdata;
    }
    else{
      print(dateGet.statusCode);
    }
  }

}