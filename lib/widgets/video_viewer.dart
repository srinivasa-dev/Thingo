import 'dart:io';

import 'package:flutter/material.dart';
import 'package:thingo/globals.dart';
import 'package:thingo/utils/app_color.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class VideoViewer extends StatefulWidget {
  final String vidPath;
  final VideoPlayerController vidCont;

  const VideoViewer({Key? key, required this.vidPath, required this.vidCont}) : super(key: key);

  @override
  State<VideoViewer> createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {

  void shareImage() async {
    Share.shareFiles([widget.vidPath],);
  }

  final Globals _globals = Globals();

  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   widget.vidCont.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: (){
              _globals.downloadStatus(widget.vidPath);
            },
            icon: const Icon(
              Icons.file_download,
            ),
          ),
          IconButton(
            onPressed: (){
              shareImage();
            },
            icon: const Icon(
              Icons.share,
            ),
          ),
          const SizedBox(width: 10.0,),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              if(widget.vidCont.value.isPlaying){
                widget.vidCont.pause();
              } else {
                widget.vidCont.play();
              }
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.expand(
                child: Center(
                  child: Hero(
                    tag: widget.vidPath,
                    child: AspectRatio(
                      aspectRatio: widget.vidCont.value.aspectRatio,
                      child: VideoPlayer(
                          widget.vidCont,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !widget.vidCont.value.isPlaying,
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: AppColor.black5,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    size: 55,
                    color: AppColor.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
