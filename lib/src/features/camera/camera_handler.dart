import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../views/camera/testCamera.dart';
import 'camera_model.dart';

class CameraHandler extends StatefulWidget {
  CameraHandler({Key? key}) : super(key: key);

  @override
  State<CameraHandler> createState() => _CameraHandlerState();
}

class _CameraHandlerState extends State<CameraHandler> {
  late final Future<List<CameraDescription>> _func;

  @override
  void initState() {
    super.initState();
    _func = availableCameras();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CameraDescription>>(
        future: _func,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider.value(
                            value: Provider.of<CameraModel>(context),
                            child: TakePictureScreen(
                                camera: snapshot.data!.first)))),
                child: const Text("Test camera page"));
          }
          return const CircularProgressIndicator();
        });
  }
}
