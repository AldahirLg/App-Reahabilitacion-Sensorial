import 'dart:convert';

import 'package:devices_reah/services/socket.dart';
import 'package:devices_reah/views/device_concept_list.dart';
import 'package:devices_reah/views/devices.dart';
import 'package:devices_reah/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

int gradiantColors = 0;

class DeviceConceptDetails extends StatefulWidget {
  const DeviceConceptDetails({super.key, required this.device});

  final Device device;

  @override
  State<DeviceConceptDetails> createState() => _DeviceConceptDetailsState();
}

class _DeviceConceptDetailsState extends State<DeviceConceptDetails> {
  bool isSwitchLight = false;
  bool isSwitchBubble = false;
  late String colorSok;

  late WebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    _connectToWebSocket();
  }

  void _connectToWebSocket() async {
    channel = WebSocketChannel.connect(Uri.parse(espurl));
    try {
      await channel.ready;
      channel.stream.listen(
        (message) {
          _ListenToWebSocket(message);
        },
        onDone: () {
          print('Closed');
        },
        onError: (error) {
          print('Error: $error');
        },
      );
    } catch (e) {
      print('WS no conectado');
    }
  }

  void _ListenToWebSocket(String message) {
    channel.stream.listen((message) {
      var parsedMessage = jsonDecode(message);
      print(message);
      setState(() {
        isSwitchBubble = parsedMessage['relay_state'];
        isSwitchLight = parsedMessage['neopixel_state'];
        colorSok = parsedMessage['color'];
      });
    });
  }

  @override
  void dispose() {
    _closeWSChannel();
    super.dispose();
  }

  void _closeWSChannel() {
    if (channel != null) {
      print('Closing WebSocket');
      channel.sink.close();
      print('WebSocket closed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0.0,
        leading: BackButton(
          onPressed: () {
            _closeWSChannel();
            Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 650),
                pageBuilder: (context, animation, _) {
                  return FadeTransition(
                    opacity: animation,
                    child: const DeviceConceptList(),
                  );
                }));
            //closeChannel();
            //stopPolling();
          },
          color: Colors.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
            child: Hero(
              tag: 'text_${widget.device.name}',
              child: Material(
                child: Text(
                  widget.device.name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      backgroundColor: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            decoration: _gradientColor(),
            child: SizedBox(
              height: size.height * 0.4,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Hero(
                          tag: widget.device.image,
                          child: Image.asset(
                            widget.device.image,
                            fit: BoxFit.fitHeight,
                          )))
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          _SwitchButton(),
          const SizedBox(height: 30),
          _buttonColors()
        ],
      ),
    );
  }

  Widget _SwitchButton() {
    return Column(
      children: [
        const Text(
          'Activar Luces',
          style: TextStyle(
              backgroundColor: Colors.white,
              color: Color.fromARGB(255, 189, 147, 214),
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
        Transform.scale(
          scale: 1.2,
          child: Switch(
              value: isSwitchLight,
              onChanged: (value) {
                if (value == true) {
                  print('Neo_On');

                  sendRequest('neopixel_on');
                } else {
                  print('Neo_off');

                  gradiantColors = 6;
                  sendRequest('neopixel_off');
                }
                setState(() {
                  isSwitchLight = value;
                });
                //_sendMessage(jsonEncode({'type': 'neopixel', 'state': value}));
              }),
        ),
        const Text(
          'Activar Burbujas',
          style: TextStyle(
              backgroundColor: Colors.white,
              color: Color.fromARGB(255, 189, 147, 214),
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
        Transform.scale(
          scale: 1.2,
          child: Switch(
              value: isSwitchBubble,
              onChanged: (value) {
                if (value == true) {
                  print('On');

                  sendRequest('relay_on');
                } else {
                  print('off');

                  sendRequest('relay_off');
                }
                setState(() {
                  isSwitchBubble = value;
                });
                // _sendMessage(jsonEncode({'type': 'relay', 'state': value}));
              }),
        )
      ],
    );
  }

  Widget _buttonColors() {
    double ButtonHaW = 70;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: ButtonHaW,
          height: ButtonHaW,
          child: ElevatedButton(
            onPressed: () {
              sendRequest('color_red');
              gradiantColors = 1;
              setState(() {
                isSwitchLight = true;
              });
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.red),
            child: const Text(''),
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: ButtonHaW,
          height: ButtonHaW,
          child: ElevatedButton(
            onPressed: () {
              gradiantColors = 2;
              sendRequest('color_blue');
              setState(() {
                isSwitchLight = true;
              });
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue),
            child: const Text(''),
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: ButtonHaW,
          height: ButtonHaW,
          child: ElevatedButton(
            onPressed: () {
              sendRequest('color_green');
              setState(() {
                gradiantColors = 3;
                isSwitchLight = true;
              });
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green),
            child: const Text(''),
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: ButtonHaW,
          height: ButtonHaW,
          child: ElevatedButton(
            onPressed: () {
              gradiantColors = 4;
              sendRequest('color_yellow');
              setState(() {
                isSwitchLight = true;
              });
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.yellow),
            child: const Text(''),
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: ButtonHaW,
          height: ButtonHaW,
          child: ElevatedButton(
            onPressed: () {
              gradiantColors = 5;
              sendRequest('color_magenta');
              setState(() {
                isSwitchLight = true;
              });
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.pink),
            child: const Text(''),
          ),
        )
      ],
    );
  }

  BoxDecoration _gradientColor() {
    Color color;
    switch (gradiantColors) {
      case 1:
        color = const Color.fromARGB(255, 255, 214, 213);
        break;
      case 2:
        color = const Color.fromARGB(255, 229, 242, 255);
        break;
      case 3:
        color = const Color.fromARGB(255, 233, 255, 223);
        break;
      case 4:
        color = const Color.fromARGB(255, 255, 249, 197);
        break;
      case 5:
        color = const Color.fromARGB(255, 255, 215, 236);
        break;
      case 6:
        color = Colors.white;
      default:
        color = Colors.white; // Color predeterminado
    }
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, color, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }
}
