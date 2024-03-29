import 'dart:io';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class GalleryGridItem extends StatelessWidget {
  final Uint8List item;

  const GalleryGridItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Hero(
          tag: item,
          child: ExtendedImage.memory(item,
              fit: BoxFit.fill, cacheHeight: 150, cacheWidth: 250 ,enableMemoryCache: false, ),
        ),
      ),
    );
  }
}
