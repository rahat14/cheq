import 'dart:io';
import 'dart:typed_data';

import 'package:cheq/models/ImageObj.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class GalleryGridItem extends StatelessWidget {
  final ImageObj item;
  final int index;

  const GalleryGridItem({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Hero(
          tag: index.toString(),
          child: Platform.isAndroid
              ? ExtendedImage.file(
                  item.file,
                  fit: BoxFit.fill,
                  cacheHeight: 150,
                  cacheWidth: 250,
                  enableMemoryCache: false,
                )
              : ExtendedImage.memory(
                  item.uint8list!,
                  fit: BoxFit.fill,
                  cacheHeight: 150,
                  cacheWidth: 250,
                  enableMemoryCache: false,
                ),
        ),
      ),
    );
  }
}
