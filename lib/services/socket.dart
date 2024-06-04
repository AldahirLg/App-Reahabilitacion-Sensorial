import 'package:web_socket_channel/web_socket_channel.dart';

const espurl = 'ws://192.168.60.101:81';
final esp32url = Uri.parse('ws://192.168.60.101:81');
final channel = WebSocketChannel.connect(esp32url);
var neopixelState;
var relayState;
var colorSocket;

class WebSocketService {
  late WebSocketChannel channel;

  WebSocketService(String url) {
    channel = WebSocketChannel.connect(Uri.parse(url));
  }

  void sendMessage(String message) {
    channel.sink.add(message);
  }

  Stream get stream => channel.stream;

  void close() {
    channel.sink.close();
  }
}
