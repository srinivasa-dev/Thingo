import 'dart:io';

import 'package:flutter/material.dart';
import 'package:thingo/globals.dart';
import 'package:thingo/utils/app_color.dart';
import 'package:share_plus/share_plus.dart';


class PhotoViewer extends StatefulWidget {
  final String imgPath;

  const PhotoViewer({Key? key, required this.imgPath}) : super(key: key);

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {

  void shareImage() async {
    Share.shareXFiles([XFile(widget.imgPath)],);
  }

  final Globals _globals = Globals();

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              _globals.downloadStatus(path: widget.imgPath, context: context, isImage: true);
            },
            icon: const Icon(
              Icons.file_download,
            ),
          ),
          IconButton(
            onPressed: () {
              shareImage();
            },
            icon: const Icon(
              Icons.share,
            ),
          ),
          const SizedBox(width: 10.0,),
        ],
      ),
      body: InteractiveViewer(
        maxScale: 8.0,
        child: SizedBox.expand(
          child: Center(
            child: Hero(
              tag: widget.imgPath,
              child: Image.file(
                File(widget.imgPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
