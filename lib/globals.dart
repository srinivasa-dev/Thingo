import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thingo/widgets/custom_text_button.dart';


class Globals {

  Orientation getOrientation(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return orientation;
  }

  void downloadStatus({required String path, required BuildContext context, required bool isImage}) async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }

    var file = File(path);
    await file.copy(directory!.path+'/'+path.split('/').last);

    showDialog(
      context: context,
      builder: (cont) {
        return AlertDialog(
          title: Text('${isImage ? 'Image' : 'Video'} Downloaded!'),
          content: Text('You can find it in ${directory!.path}'),
          actions: [
            CustomTextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              btnTxt: 'OK',
              enableBorder: false,
            )
          ],
        );
      },
    );
  }

  void requestStoragePermission({required void Function() onGranted, required void Function() onDenied}) async {
    PermissionStatus result = await Permission.storage.request();
    PermissionStatus result2 = await Permission.manageExternalStorage.request();

    if (result == PermissionStatus.granted && result2 == PermissionStatus.granted) {
      onGranted();
    } else {
      onDenied();
    }
  }

  requestCameraPermission({required void Function() onGranted, required void Function() onDenied}) async {
    PermissionStatus result = await Permission.camera.request();

    if (result == PermissionStatus.granted) {
      onGranted();
    } else {
      onDenied();
    }
  }

  requestMicPermission({required void Function() onGranted, required void Function() onDenied}) async {
    PermissionStatus result = await Permission.microphone.request();

    if (result == PermissionStatus.granted) {
      onGranted();
    } else {
      onDenied();
    }
  }
}