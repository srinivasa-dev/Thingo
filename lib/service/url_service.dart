
import 'package:http/http.dart';

class UrlService {

  String baseUrl = 'https://api.shrtco.de/v2/shorten?url=';

  Future<Response> getUrl(String url) async {
    final response = await get(Uri.parse('$baseUrl$url'),);

    return response;
  }

}