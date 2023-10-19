import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  Network(this.uri);

  String uri;

  Map<String, String> getHeaders() {
    return {
      'Content-Type': 'application/json',
      'X-CoinAPI-Key': 'C05DAD5C-FAD8-4616-861F-C20B7F7C3608'
    };
  }

  Future get() async {
    Map<String, String> headers = getHeaders();
    http.Response response = await http.get(Uri.parse(uri), headers: headers);
    if (response.statusCode == 200) {
      // Response success
      return jsonDecode(response.body);
    } else {
      // Respone error
      return null;
    }
  }
}
