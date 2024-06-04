import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

const String esp32Url = 'http://192.168.60.101';

Future<void> sendRequest(String color) async {
  final url = Uri.parse('$esp32Url/$color');
  try {
    final response = await get(url);
    if (response.statusCode == 200) {
      //print(response.body);
      print('Respuesta');
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
