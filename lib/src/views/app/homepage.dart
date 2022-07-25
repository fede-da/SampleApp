import 'dart:io';

import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/src/common_widgets/image_show.dart';
import 'package:sample_app/src/common_widgets/myspacer.dart';
import 'package:sample_app/src/features/blocs/camera_bloc/camera_bloc.dart';
import 'package:sample_app/src/features/camera/camera_handler.dart';
import 'package:sample_app/src/features/camera/camera_model.dart';
import 'package:sample_app/src/features/phone_library/phone_library.dart';
import 'package:sample_app/src/views/camera/testCamera.dart';

import '../../features/authentication/bloc/authentication_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PhoneLibrary _pl = PhoneLibrary();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CameraModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<CameraBloc, CameraState>(
          bloc: BlocProvider.of<CameraBloc>(context),
          builder: (context, state) {
            if (state is CameraReady) {
              return TakePictureScreen(
                camera: BlocProvider.of<CameraBloc>(context)
                    .controller!
                    .description,
              );
            }
            return SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(children: [
                    MySpacer(height: 20),
                    Consumer<CameraModel>(
                      builder: (context, value, child) =>
                          ImageShow(image: value.lastImage),
                    ),
                    CameraHandler(),
                    MySpacer(height: 40),
                    // IconButton(
                    //     onPressed: () {
                    //       BlocProvider.of<CameraBloc>(context)
                    //           .add(CameraInitialized());
                    //     },
                    //     icon: const Icon(Icons.camera_alt)),
                    _pl,
                    ElevatedButton(
                      onPressed: () =>
                          BlocProvider.of<AuthenticationBloc>(context).logout(),
                      child: const Text("Logout"),
                    ),
                    MySpacer(height: 20),
                  ]),
                ),
              ),
            );
          },
          listener: (context, state) {
            if (state is CameraFailure) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
    );
  }
}
