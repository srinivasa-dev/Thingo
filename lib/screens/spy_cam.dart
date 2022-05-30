import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:thingo/globals.dart';
import 'package:thingo/main.dart';
import 'package:thingo/utils/app_color.dart';
import 'package:camera/camera.dart';
import 'package:thingo/widgets/custom_text_button.dart';
import 'package:app_settings/app_settings.dart';


class SpyCam extends StatefulWidget {
  const SpyCam({Key? key}) : super(key: key);

  @override
  State<SpyCam> createState() => _SpyCamState();
}

class _SpyCamState extends State<SpyCam> {

  late CameraController _cameraController;

  bool _isFrontCam = false;
  bool _isPhotoMode = false;
  bool _isInitialized = false;

  final Globals _globals = Globals();

  initializeCamera(int cam) {
    _cameraController = CameraController(cameras[cam], ResolutionPreset.max);
    _cameraController.initialize().then((_) async {
      if (!mounted) {
        return;
      }
      await _cameraController.setFlashMode(FlashMode.off);
      setState(() {
        _isInitialized = true;
      });
    });
  }

  // for volume button override. Setup is done in app/src/main/kotlin/yadav/srinivasa/thingo/MainActivity.kt
  static const _volumeButtonChannel = MethodChannel('mychannel');

  @override
  void initState() {
    _volumeButtonChannel.setMethodCallHandler((call) {
      if (call.method == "volumeBtnPressed") {
        if (call.arguments == "volume_down") {
          onCapture();
        } else if (call.arguments == "volume_up") {
          onCapture();
        }
      }

      return Future.value(null);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
          context: context,
          builder: (cont) {
            return AlertDialog(
              title: const Text('About Spy Cam!'),
              content: const Text('This feature allows you to record while the app is in the background or even when the screen is locked.\n\n'
                  'Works better when you keep the app open and lock the screen.'),
              actions: [
                CustomTextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  btnTxt: 'CLOSE',
                  enableBorder: false,
                )
              ],
            );
          },
      );
    });
    initializeCamera(0);
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  void toastMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (_cameraController == null) {
      return;
    }

    final CameraController cameraController = _cameraController;

    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  final double _minAvailableZoom = 1.0;
  final double _maxAvailableZoom = 1.0;
  double _currentScale = 1.0;
  double _baseScale = 1.0;
  final int _pointers = 0;

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (_cameraController == null || _pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);

    await _cameraController.setZoomLevel(_currentScale);
  }

  onCapture() async {
    if(!_isPhotoMode) {
      if (!_cameraController.value.isRecordingVideo) {
        await _cameraController.prepareForVideoRecording();
        await _cameraController.startVideoRecording();
      } else if (_cameraController.value.isRecordingVideo) {
        final video = await _cameraController.stopVideoRecording();
        await GallerySaver.saveVideo(video.path);
        File(video.path).deleteSync();
        toastMessage('Video Saved in Gallery!');
      }
    } else {
      final pic = await _cameraController.takePicture();
      await GallerySaver.saveImage(pic.path);
      File(pic.path).deleteSync();
      toastMessage('Photo Saved in Gallery!');
    }
    setState(() {
      _cameraController;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        backgroundColor: AppColor.black,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () async {
              if (_cameraController.value.flashMode == FlashMode.off) {
                await _cameraController.setFlashMode(FlashMode.torch);
              } else if (_cameraController.value.flashMode == FlashMode.torch) {
                await _cameraController.setFlashMode(FlashMode.off);
              }
              setState(() {
                _cameraController;
              });
            },
            icon: Icon(
                _cameraController.value.flashMode == FlashMode.off ? Icons.flash_off : Icons.flash_on,
            ),
            iconSize: 20.0,
            color: AppColor.white,
            splashRadius: 20.0,
          ),
        ],
      ),
      body: !_cameraController.value.isInitialized ? permissionUI() : Stack(
            children: [
              Positioned.fill(
                child: CameraPreview(
                  _cameraController,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onScaleStart: _handleScaleStart,
                        onScaleUpdate: _handleScaleUpdate,
                        onTapDown: (TapDownDetails details) =>
                            onViewFinderTap(details, constraints),
                      );
                    }),
                  ),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  color: AppColor.black5,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _cameraController.value.isRecordingVideo ? const SizedBox(height: 30.0, width: 30.0,) : IconButton(
                              onPressed: () {
                                setState(() {
                                  if(_isFrontCam) {
                                    initializeCamera(0);
                                  } else {
                                    initializeCamera(1);
                                  }
                                  _isFrontCam = !_isFrontCam;
                                });
                              },
                              icon: const Icon(
                                Icons.flip_camera_ios
                              ),
                              iconSize: 30.0,
                              color: AppColor.white,
                              splashRadius: 30.0,
                            ),
                            GestureDetector(
                              onTap: () async {
                                await onCapture();
                              },
                              child: Container(
                                width: 55,
                                height: 55,
                                // margin: const EdgeInsets.only(bottom: 40.0),
                                decoration: BoxDecoration(
                                  color: AppColor.black5,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                alignment: Alignment.center,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  width: !_cameraController.value.isRecordingVideo ? 50 : 25,
                                  height: !_cameraController.value.isRecordingVideo ? 50 : 25,
                                  decoration: BoxDecoration(
                                    color: _isPhotoMode ? AppColor.white : !_cameraController.value.isRecordingVideo ? AppColor.red : AppColor.white,
                                    borderRadius: BorderRadius.circular(!_cameraController.value.isRecordingVideo ? 100 : 5),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPhotoMode = !_isPhotoMode;
                                });
                              },
                              icon: Icon(
                                  _isPhotoMode ? Icons.videocam : Icons.camera_alt
                              ),
                              iconSize: 30.0,
                              color: AppColor.white,
                              splashRadius: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
      ),
    );
  }

  Widget permissionUI() {
    return Visibility(
      visible: !_isInitialized,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "If you have not granted permission for Camera and Microphone please grant them!",
              style: TextStyle(fontSize: 18.0, color: AppColor.textGrey1),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0,),
            CustomTextButton(
              onPressed: () async {
                bool camGranted = false, micGranted = false;

                await _globals.requestCameraPermission(
                  onGranted: (){
                    setState(() {
                      camGranted = true;
                    });
                    initializeCamera(0);
                  },
                  onDenied: () async {
                    setState(() {
                      camGranted = false;
                    });
                  },
                );
                await _globals.requestMicPermission(
                  onGranted: (){
                    setState(() {
                      micGranted = true;
                    });
                    initializeCamera(0);
                  },
                  onDenied: () async {
                    setState(() {
                      micGranted = false;
                    });
                  },
                );
                if (!camGranted || !micGranted) {
                  await AppSettings.openAppSettings();
                  initializeCamera(0);
                }
              },
              btnTxt: 'Grant Permission',
            ),
          ],
        ),
      ),
    );
  }

}
