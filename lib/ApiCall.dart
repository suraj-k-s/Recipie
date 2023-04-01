import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'constants.dart' as constant;

const String baseUrl = 'http://${constant.ipAddress}/Recipie/Web/Api/';

class ApiCall {
  var client = http.Client();
  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);

    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      debugPrint('Error in Api Call');
    }
  }

  Future<dynamic> post(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    var response = await client.post(url, body: _payload);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      debugPrint('Error in Api Call');
    }
  }

  Future<dynamic> put(String api) async {}
  Future<dynamic> delete(String api) async {}
}
