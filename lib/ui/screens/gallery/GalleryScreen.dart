import 'dart:io';

import 'package:cheq/models/AlbumWithLastImage.dart';
import 'package:cheq/models/ImageObj.dart';
import 'package:cheq/ui/screens/fullScreenView/FullScreenImage.dart';
import 'package:cheq/ui/screens/gallery/controller/GalleryController.dart';
import 'package:cheq/ui/screens/gallery/widget/GalleryItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/textStyle.dart';

class GalleryScreen extends StatefulWidget {
  final AlbumWithLastImage? directory;
  final String? iosDirectoryName;

  const GalleryScreen(
      {super.key, required this.directory, required this.iosDirectoryName});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final ScrollController _scrollController = ScrollController();
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (canPop){
        if(canPop){
          Get.find<GalleryController>().clearMemory();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
                Platform.isAndroid
                    ? widget.directory?.name ?? ''
                    : widget.iosDirectoryName.toString(),
                style: CustomTextStyle.of(context)
                    .titleBoldStyle(color: Colors.black)
                    .copyWith(fontSize: 26)),
          ),
          body: GetBuilder<GalleryController>(builder: (cont) {
            return GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8),
              itemCount: cont.galleryImages.length,
              itemBuilder: (context, index) {
                var obj  = cont.galleryImages[index];
                return InkWell(
                  onTap: () {
                    Get.to(FullScreenImage(
                      imageObj: obj ,
                      index: index,
                    ));
                  },
                  child: GalleryGridItem(
                    item: obj,
                    index: index,
                  ),
                );
              },
            );
          })),
    );
  }

  @override
  void initState() {
    super.initState();
    Get.find<GalleryController>().getGalleryData(
        widget.directory?.album?.path, widget.iosDirectoryName.toString());

    if (Platform.isAndroid) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          page = page + 1;
          Get.find<GalleryController>().loadMore(page);
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
