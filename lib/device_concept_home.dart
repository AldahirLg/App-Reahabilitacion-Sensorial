import 'package:devices_reah/device_concept_list.dart';
import 'package:devices_reah/devices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DeviceConceptHome extends StatelessWidget {
  const DeviceConceptHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! < -20) {
            Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 650),
                pageBuilder: (context, animation, _) {
                  return FadeTransition(
                    opacity: animation,
                    child: const DeviceConceptList(),
                  );
                }));
          }
        },
        child: Stack(
          children: [
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                    Color(0xFFFFFFFF),
                    Color.fromARGB(255, 166, 223, 247)
                  ]))),
            ),
            Positioned(
                height: size.height * 0.19,
                left: 0,
                right: 0,
                top: size.height * 0.30,
                child: Hero(
                    tag: '2', child: Image.asset('assets/images/Logo.png'))),
          ],
        ),
      ),
    );
  }
}
