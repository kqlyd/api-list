import 'dart:convert';

import 'package:robo_test/model.dart';
import 'package:http/http.dart' as http;

class ApiListRepository {
  String listUrl = 'https://api.publicapis.org/entries';

  Future<ApiResponse> getList() async {
    var url = Uri.parse(listUrl);
    var response = await http.get(url);
    return ApiResponse.fromJson(jsonDecode(response.body));
  }
}
