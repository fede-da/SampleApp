import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ImageShow extends StatelessWidget {
  ImageShow({Key? key, required this.image}) : super(key: key);

  XFile? image;

  @override
  Widget build(BuildContext context) => image == null
      ? Center(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: const Text("No Image to display"),
          ),
        )
      : Image.file(
          File(image!.path),
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.6,
          fit: BoxFit.contain,
        );
}
