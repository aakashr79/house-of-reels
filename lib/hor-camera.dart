import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  final List<CameraDescription> cameras;

  /// Default Constructor
  const CameraApp({
    super.key,
    required this.cameras,
  });

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  getCamera() {
    final frontCams = widget.cameras
        .where((element) => element.lensDirection == CameraLensDirection.back);
    return frontCams.isNotEmpty ? frontCams.first : widget.cameras.first;
  }

  @override
  void initState() {
    super.initState();

    controller = CameraController(getCamera(), ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: CameraPreview(controller),
    );
  }
}
