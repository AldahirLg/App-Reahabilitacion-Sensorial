import 'package:devices_reah/views/device_concept_cubo.dart';
import 'package:devices_reah/views/device_concept_deatils.dart';
import 'package:devices_reah/views/device_concept_home.dart';
import 'package:devices_reah/views/devices.dart';
import 'package:devices_reah/services/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 300);
const _initialPage = 3.0;

class DeviceConceptList extends StatefulWidget {
  const DeviceConceptList({super.key});

  @override
  State<DeviceConceptList> createState() => _DeviceConceptListState();
}

class _DeviceConceptListState extends State<DeviceConceptList> {
  final _pageDeviceController =
      PageController(viewportFraction: 0.35, initialPage: _initialPage.toInt());
  final _pageTextController = PageController(initialPage: _initialPage.toInt());
  double _currentPage = _initialPage;
  double _textPage = _initialPage;

  void _deviceScrollListener() {
    setState(() {
      _currentPage = _pageDeviceController.page!;
    });
  }

  void _textScrollListener() {
    _textPage = _currentPage;
  }

  @override
  void initState() {
    _pageDeviceController.addListener(_deviceScrollListener);
    _pageTextController.addListener(_textScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageDeviceController.removeListener(_deviceScrollListener);
    _pageTextController.removeListener(_textScrollListener);
    _pageDeviceController.dispose();
    _pageTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 650),
                pageBuilder: (context, animation, _) {
                  return FadeTransition(
                    opacity: animation,
                    child: const DeviceConceptHome(),
                  );
                }));
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned(
              left: 20,
              right: 20,
              bottom: -size.height * 0.1,
              height: size.height * 0.29,
              child: const DecoratedBox(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 171, 214, 249),
                  blurRadius: 90,
                  offset: Offset.zero,
                  spreadRadius: 45,
                )
              ]))),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            height: 90,
            child: PageView.builder(
                itemCount: devices.length,
                controller: _pageTextController,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final opacity =
                      (1 - (index - _textPage).abs()).clamp(0.0, 1.0);
                  return Opacity(
                    opacity: opacity,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.2),
                      child: Hero(
                        tag: 'text_${devices[index]}',
                        child: Material(
                          child: Text(
                            devices[index].name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Transform.scale(
            scale: 1.5,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
                controller: _pageDeviceController,
                scrollDirection: Axis.vertical,
                itemCount: devices.length + 1,
                onPageChanged: (value) {
                  if (value < devices.length) {
                    _pageTextController.animateToPage(value,
                        duration: _duration, curve: Curves.easeOut);
                  }
                },
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const SizedBox.shrink();
                  }
                  final device = devices[index - 1];
                  final result = _currentPage - index + 1;
                  final value = -0.4 * result + 1.2;
                  final opacity = value.clamp(0.0, 1.0);
                  if (kDebugMode) {
                    print(result);
                  }
                  return GestureDetector(
                    onTap: () {
                      if (result == 0) {
                        //sendRequest('');
                        if (index == 4) {
                          Navigator.of(context).push(PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 650),
                              pageBuilder: (context, animation, _) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: DeviceConceptDetails(device: device),
                                );
                              }));
                        }
                        if (index == 3) {
                          Navigator.of(context).push(PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 650),
                              pageBuilder: (context, animation, _) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: DeviceConceptCubo(device: device),
                                );
                              }));
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 90),
                      child: Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..translate(
                              0.0,
                              MediaQuery.of(context).size.height /
                                  2.6 *
                                  (1 - value).abs(),
                            )
                            ..scale(value),
                          child: Opacity(
                            opacity: opacity,
                            child: Hero(
                              tag: device.name,
                              child: Image.asset(
                                device.image,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          )),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
