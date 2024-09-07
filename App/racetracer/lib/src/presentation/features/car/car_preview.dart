import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';

class CarPreviewPage extends StatefulWidget {
  const CarPreviewPage({super.key});

  @override
  State<CarPreviewPage> createState() => _CarPreviewPageState();
}

class _CarPreviewPageState extends State<CarPreviewPage> {
  Flutter3DController controller = Flutter3DController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('bdrda'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            onPressed: () {
              controller.resetAnimation();
            },
            child: const Icon(Icons.replay_circle_filled),
          ),
          const SizedBox(
            height: 4,
          ),
          const SizedBox(
            height: 4,
          ),
          const SizedBox(
            height: 4,
          ),
          FloatingActionButton.small(
            onPressed: () {
              controller.setCameraOrbit(
                -75,
                75,
                20,
              );
              // controller.setCameraTarget(
              //   Random().nextDouble(),
              //   Random().nextDouble(),
              //   Random().nextDouble(),
              // );
            },
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(
            height: 4,
          ),
          FloatingActionButton.small(
            onPressed: () {
              // controller.setCameraTarget(5, 0, 0);

              //controller.resetCameraTarget();
            },
            child: const Icon(Icons.cameraswitch_outlined),
          )
        ],
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Flutter3DViewer(
          //If you don't pass progressBarColor the color of defaultLoadingProgressBar will be grey.
          //You can set your custom color or use [Colors.transparent] for hiding loadingProgressBar.
          progressBarColor: Colors.blue,
          controller: controller,
          src: 'assets/models/car.glb', //3D model with different animations
          //src: 'assets/sheen_chair.glb', //3D model with different textures
          // src:'https://modelviewer.dev/shared-assets/models/Astronaut.glb', // 3D model from URL
        ),
      ),
    );
  }
}
