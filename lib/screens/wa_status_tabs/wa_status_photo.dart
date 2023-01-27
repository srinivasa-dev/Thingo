import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:thingo/globals.dart';
import 'package:thingo/widgets/photo_viewer.dart';


class WaStatusPhoto extends StatefulWidget {
  const WaStatusPhoto({Key? key}) : super(key: key);

  @override
  State<WaStatusPhoto> createState() => _WaStatusPhotoState();
}

class _WaStatusPhotoState extends State<WaStatusPhoto> {

  // final Directory _photoDir = Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
  final Directory _photoDir = Directory('/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses');

  List<String> imageList = [];

  @override
  void initState() {

    if(!Directory(_photoDir.path).existsSync()){
      setState(() {
        imageList = [];
      });
    } else {
      setState(() {
        imageList = _photoDir
            .listSync()
            .map((item) => item.path)
            .where((item) => item.endsWith(".jpg"))
            .toList(growable: false);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: imageList.isNotEmpty ? MasonryGridView.count(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        crossAxisCount: Globals().getOrientation(context) == Orientation.portrait ? 2 : 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          String imgPath = imageList[index];
          return Material(
            elevation: 8.0,
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PhotoViewer(imgPath: imgPath)));
                },
                child: Hero(
                    tag: imgPath,
                    child: Image.file(
                      File(imgPath),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          );
        },
      ) : installText(),
    );
  }

  Widget installText() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Text(
          "No Photo Status Found!",
          style: TextStyle(fontSize: 18.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

}
