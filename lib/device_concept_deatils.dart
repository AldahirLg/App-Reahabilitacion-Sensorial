import 'dart:ffi';
import 'dart:typed_data';

import 'package:devices_reah/devices.dart';
import 'package:devices_reah/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        leading: const BackButton(
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
                print('On');
                sendRequest('neopixel_on');
              } else {
                gradiantColors = 6;
                print('off');
                sendRequest('neopixel_off');
              }
              setState(() {
                isSwitchLight = value;
              });
            },
          ),
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
            },
          ),
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
        color = Colors.red;
        break;
      case 2:
        color = Colors.blue;
        break;
      case 3:
        color = Colors.green;
        break;
      case 4:
        color = Colors.yellow;
        break;
      case 5:
        color = Colors.pink;
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
