import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Network {

  getRepos(int offset) async {
    String url =
        "https://api.github.com/search/repositories?q=flutter+language:dart&page=${offset}&per_page=10";
    var response = await http.get(url);
    var jsonResponse = convert.jsonDecode(response.body);

    return jsonResponse['items'];
  }
}
