import 'dart:convert';
import 'package:http/http.dart' as http;

class Http_get {
  final String url;
  Http_get(this.url);

  Future<dynamic> getJsonData() async {
    http.Response response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
    else
      print('연결실패');
  }
}

class Http_post {
  final String url;
  var body;
  Http_post(this.url, this.body);

  Future<dynamic> getJsonData() async {
    http.Response response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body
    );

    print(response.body);

    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
    else{
      print('연결 실패 코드: ');
      print(response.statusCode);

      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }

  }
}

class Http_delete {
  final String url;
  Http_delete(this.url);

  Future<dynamic> getJsonData() async {

    print("1c " + url);
    http.Response response = await http.delete(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
    else
      print('연결실패');
  }
}