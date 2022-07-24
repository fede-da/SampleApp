import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraModel extends ChangeNotifier {
  XFile? lastImage;

  XFile? getFile() => lastImage;

  void setFile(XFile? file) {
    lastImage = file;
    notifyListeners();
  }
}
