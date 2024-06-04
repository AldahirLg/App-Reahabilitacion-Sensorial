import 'package:devices_reah/views/device_concept_list.dart';
import 'package:flutter/material.dart';

class DeviceConceptHome extends StatefulWidget {
  const DeviceConceptHome({super.key});

  @override
  State<DeviceConceptHome> createState() => _DeviceConceptHomeState();
}

class _DeviceConceptHomeState extends State<DeviceConceptHome> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! < -12) {
            Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 650),
                pageBuilder: (context, animation, _) {
                  return FadeTransition(
                    opacity: animation,
                    child: const DeviceConceptList(),
                  );
                }));
          } else if (details.primaryDelta! < 12) {
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
            SizedBox.expand(
              child: Image.asset(
                'assets/images/Home.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                    Color(0xFFFFFFFF),
                    Color.fromARGB(255, 255, 255, 255)
                  ]))),
            ),
            Positioned(
              height: size.height * 0.15,
              left: 0,
              right: 0,
              top: size.height * 0.20,
              child:
                  Hero(tag: '2', child: Image.asset('assets/images/Logo.png')),
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Deslizar',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
