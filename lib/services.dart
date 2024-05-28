import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'Dart:io';

Timer? pollingTimer;
const String esp32Url = 'http://192.168.60.101';

Future<void> sendRequest(String color) async {
  final url = Uri.parse('$esp32Url/$color');
  try {
    final response = await get(url);
    if (response.statusCode == 200) {
      print(response.body);
      print(url);
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> checkStatus() async {
  final url = Uri.parse(esp32Url);
  try {
    final response = await get(url);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

void startPolling() {
  pollingTimer = Timer.periodic(Duration(seconds: 2), (timer) {
    checkStatus();
    print('Start');
  });
}

void stopPolling() {
  if (pollingTimer != null) {
    pollingTimer!.cancel(); // Detener el timer si existe
    pollingTimer = null; // Establecer la referencia del timer a null
    print('Stop');
  }
}
