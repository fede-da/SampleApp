part of 'camera_bloc.dart';

abstract class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraState {}

class CameraReady extends CameraState {}

class CameraFailure extends CameraState {
  final String error;

  CameraFailure({this.error = "CameraFailure"});

  @override
  List<Object> get props => [error];
}

class CameraCaptureInProgress extends CameraState {}

class CameraCaptureSuccess extends CameraState {
  final String path;

  CameraCaptureSuccess(this.path);
}

class CameraCaptureFailure extends CameraReady {
  final String error;

  CameraCaptureFailure({this.error = "CameraFailure"});

  @override
  List<Object> get props => [error];
}