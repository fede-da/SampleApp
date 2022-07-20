import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:camera/camera.dart';

import '../../../utils/camera_utils.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  late final CameraUtils _cameraUtils;
  late final ResolutionPreset _resolutionPreset;
  late final CameraLensDirection _cameraLensDirection;

  late CameraController? _controller;

  CameraBloc() : super(CameraInitial()) {
    _cameraUtils = CameraUtils();
    _resolutionPreset = ResolutionPreset.high;
    _cameraLensDirection = CameraLensDirection.back;
    on<CameraInitialized>(_onCameraInitialized);
    on<CameraCaptured>(_onCameraCaptured);
    on<CameraStopped>(_onCameraStopped);
  }

  Stream<CameraState> _onCameraInitialized(
      CameraInitialized event, emit) async* {
    try {
      _controller = await _cameraUtils.getCameraController(
          _resolutionPreset, _cameraLensDirection);
      await _controller?.initialize();
      yield CameraReady();
    } on CameraException catch (error) {
      _controller?.dispose();
      yield CameraFailure(error: error.description ?? "Camera generic error");
    } catch (error) {
      yield CameraFailure(error: error.toString());
    }
  }

  Stream<CameraState> _onCameraCaptured(CameraCaptured event, emit) async* {
    if (state is CameraReady) {
      yield CameraCaptureInProgress();
      try {
        final path = await _cameraUtils.getPath();
        await _controller?.takePicture();
        yield CameraCaptureSuccess(path: path);
      } on CameraException catch (error) {
        yield CameraCaptureFailure(
            error: error.description ?? "Generic camera capture failure");
      }
    }
  }

  Stream<CameraState> _onCameraStopped(CameraStopped event, emit) async* {
    _controller?.dispose();
    yield CameraInitial();
  }
}
