import 'dart:io';

import 'package:cheq/models/ImageObj.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenImage extends StatefulWidget {
  final ImageObj imageObj;
  final int index;

  const FullScreenImage(
      {super.key, required this.index, required this.imageObj});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.index.toString(),
      child: Stack(
        children: [
          Center(
            child: Container(
              color: Colors.black,
              child: Platform.isAndroid
                  ? Image.file(
                      widget.imageObj.file,
                    )
                  : Image.memory(
                      widget.imageObj.uint8list!,
                    ),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
