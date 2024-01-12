import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';

class ApiService {
  final endpoint = "https://hpb.health.gov.lk/api/get-current-statistical";

  Future<Map<String, dynamic>> getCovidData() async {
    Map<String, dynamic> data = {};
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      Logger().f("status code = ${response.statusCode}");
      data = jsonDecode(response.body);
    } else {
      data = {};
      Logger().f("status code = ${response.statusCode}");
    }
    return data['data'];
  }
}
