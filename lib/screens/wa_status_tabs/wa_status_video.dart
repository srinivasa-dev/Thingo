import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:thingo/globals.dart';
import 'package:thingo/utils/app_color.dart';
import 'package:thingo/widgets/video_viewer.dart';
import 'package:video_player/video_player.dart';


class WaStatusVideo extends StatefulWidget {
  const WaStatusVideo({Key? key}) : super(key: key);

  @override
  State<WaStatusVideo> createState() => _WaStatusVideoState();
}

class _WaStatusVideoState extends State<WaStatusVideo> {

  // final Directory _videoDir = Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
  final Directory _videoDir = Directory('/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses');

  List<VideoPlayerController> _videoController = [];

  bool permissionGranted = false;

  List<String> videoList = [];

  void videoInitialize() {
    if(!Directory(_videoDir.path).existsSync()){
      setState(() {
        videoList = [];
        _videoController = [];
      });
    } else {
      setState(() {

        videoList = _videoDir
            .listSync()
            .map((item) => item.path)
            .where((item) => item.endsWith(".mp4"))
            .toList(growable: false);

        for(String vid in videoList) {
          _videoController.add(VideoPlayerController.file(File(vid))..initialize().then((_) {
            setState(() {});
          }),);
        }
      });
    }
  }

  @override
  void initState() {
    videoInitialize();
    super.initState();
  }

  @override
  void dispose() {
    for(VideoPlayerController cont in _videoController){
      cont.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _videoController.isNotEmpty ? Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: MasonryGridView.count(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        crossAxisCount: Globals().getOrientation(context) == Orientation.portrait ? 3 : 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 10,
        itemCount: _videoController.length,
        itemBuilder: (context, index) {
          String videoPath = videoList[index];
          return Material(
            elevation: 8.0,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => VideoViewer(
                  vidPath: videoList[index],
                  vidCont: _videoController[index],
                )));
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Hero(
                    tag: videoPath,
                    child: AspectRatio(
                      aspectRatio: _videoController[index].value.aspectRatio,
                      child: VideoPlayer(
                          _videoController[index]
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: AppColor.black5,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      size: 35,
                      color: AppColor.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ) : installText();
  }

  Widget installText() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Text(
          "Install WhatsApp to start seeing Statuses!",
          style: TextStyle(fontSize: 18.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

}
