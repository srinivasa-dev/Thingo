import 'dart:convert';

import 'package:thingo/models/ig_profile_model.dart';
import 'package:http/http.dart';

class IgProfileService {

  String igUrls = 'https://www.instagram.com/USERNAME/?__a=1' + 'https://i.instagram.com/api/v1/users/USER_ID/info/';

  String baseUrl = 'https://www.instagram.com/';
  String endUrl = '/?__a=1';

  Future<Response> getIgProfile(String username) async {

    final response = await get(Uri.parse('$baseUrl$username$endUrl'),);

    var data = json.decode(response.body);

    IgProfileModel _igProfileModel;

    _igProfileModel = IgProfileModel.fromJson(data);

    return response;

  }

}