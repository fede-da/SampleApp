part of 'camera_bloc.dart';

abstract class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraState {}

class CameraReady extends CameraState {}

class CameraFailure extends CameraState {
  String error;
  CameraFailure({required this.error});

  String getError() => error;
}

class CameraCaptureInProgress extends CameraState {}

class CameraCaptureSuccess extends CameraState {
  String path;
  CameraCaptureSuccess({required this.path});

  String getPath() => path;
}

class CameraCaptureFailure extends CameraState {
  String error;
  CameraCaptureFailure({required this.error});

  String getPath() => error;
}
