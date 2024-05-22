import 'package:devices_reah/devices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DeviceConceptList extends StatefulWidget {
  const DeviceConceptList({super.key});

  @override
  State<DeviceConceptList> createState() => _DeviceConceptListState();
}

class _DeviceConceptListState extends State<DeviceConceptList> {
  final _pageDeviceController = PageController(viewportFraction: 0.35);

  double _currentPage = 0.0;

  void _deviceScrollListener() {
    setState(() {
      _currentPage = _pageDeviceController.page!;
    });
  }

  @override
  void initState() {
    _pageDeviceController.addListener(_deviceScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageDeviceController.removeListener(_deviceScrollListener);
    _pageDeviceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
              left: 20,
              right: 20,
              bottom: -size.height * 0.1,
              height: size.height * 0.3,
              child: const DecoratedBox(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 90,
                  offset: Offset.zero,
                  spreadRadius: 45,
                )
              ]))),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            height: 100,
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Transform.scale(
            scale: 1.5,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
                controller: _pageDeviceController,
                scrollDirection: Axis.vertical,
                itemCount: devices.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return SizedBox.shrink();
                  }
                  final device = devices[index - 1];
                  final result = _currentPage - index + 1;
                  final value = -0.4 * result + 1.2;
                  final opacity = value.clamp(0.0, 1.0);
                  print(result);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
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
                          child: Image.asset(device.image),
                        )),
                  );
                }),
          )
        ],
      ),
    );
  }
}
