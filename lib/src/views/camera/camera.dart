import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/blocs/camera_bloc/camera_bloc.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  Widget build(BuildContext context) {
    return CameraPreview(BlocProvider.of<CameraBloc>(context).controller!);
    // return BlocConsumer<CameraBloc, CameraState>(builder: (_, state) {
    //   if (state is CameraReady) {
    //     return CameraPreview(
    //         BlocProvider.of<CameraBloc>(context).getController());
    //   } else if (state is CameraFailure) {
    //     return const Center(child: Text("Camera failure"));
    //   }
    //   return Container();
    // }, listener: (_, state) {
    //   if (state is CameraCaptureSuccess) {
    //     Navigator.of(context).pop();
    //   } else if (state is CameraCaptureFailure) {
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(const SnackBar(content: Text("Can't take photo")));
    //     Navigator.of(context).pop();
    //   } else {
    //     throw Exception("Undefined exception while taking photo");
    //   }
    // });
  }
}
