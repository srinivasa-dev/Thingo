import 'dart:io';

import 'package:flutter/material.dart';
import 'package:thingo/globals.dart';
import 'package:thingo/screens/wa_status_tabs/wa_status_photo.dart';
import 'package:thingo/screens/wa_status_tabs/wa_status_video.dart';
import 'package:thingo/utils/app_color.dart';
import 'package:thingo/widgets/custom_text_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';


class WaStatus extends StatefulWidget {
  const WaStatus({Key? key}) : super(key: key);

  @override
  State<WaStatus> createState() => _WaStatusState();
}

class _WaStatusState extends State<WaStatus> {

  bool permissionGranted = false;

  final Globals _globals = Globals();
  List<String> videoList = [];

  @override
  void initState() {
    _globals.requestStoragePermission(
      onGranted: (){
        setState(() {
          permissionGranted = true;
        });
      },
      onDenied: () {
        setState(() {
          permissionGranted = false;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text('WhatsApp Status'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Photos',
              ),
              Tab(
                text: 'Videos',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            permissionGranted ? const WaStatusPhoto() : permissionUI(),

            permissionGranted ? const WaStatusVideo() : permissionUI(),
          ],
        ),
      ),
    );
  }

  Widget installText() {
    return const Padding(
        padding: EdgeInsets.all(20.0),
      child: Center(
        child: Text(
          "Install WhatsApp to start seeing Status",
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

   Widget permissionUI() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            "App does not have permission to access the files!",
            style: TextStyle(fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0,),
          CustomTextButton(
            onPressed: () {
              _globals.requestStoragePermission(
                onGranted: (){
                  setState(() {
                    permissionGranted = true;
                  });
                },
                onDenied: () {
                  setState(() {
                    permissionGranted = false;
                  });
                },
              );
            },
            btnTxt: 'Grant Permission',
          ),
        ],
      ),
    );
   }
}
