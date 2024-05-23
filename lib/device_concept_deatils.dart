import 'package:devices_reah/devices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DeviceConceptDetails extends StatelessWidget {
  const DeviceConceptDetails({super.key, required this.device});

  final Device device;

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
              tag: 'text_${device.name}',
              child: Material(
                child: Text(
                  device.name,
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
          SizedBox(
            height: size.height * 0.4,
            child: Stack(
              children: [
                Positioned.fill(
                    child: Hero(
                        tag: device.image,
                        child: Image.asset(
                          device.image,
                          fit: BoxFit.fitHeight,
                        )))
              ],
            ),
          )
        ],
      ),
    );
  }
}
