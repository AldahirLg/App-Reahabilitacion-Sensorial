import 'package:flutter/material.dart';
import 'package:devices_reah/views/devices.dart';

class DeviceConceptCubo extends StatefulWidget {
  const DeviceConceptCubo({super.key, required this.device});

  final Device device;

  @override
  State<DeviceConceptCubo> createState() => _DeviceConceptCuboState();
}

class _DeviceConceptCuboState extends State<DeviceConceptCubo> {
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
            Navigator.pop(context);
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
                        fontWeight: FontWeight.w200),
                  ),
                )),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
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
          )
        ],
      ),
    );
  }
}
