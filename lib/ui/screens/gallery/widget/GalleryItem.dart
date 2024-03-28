import 'dart:io';

import 'package:flutter/material.dart';

class GalleryGridItem extends StatelessWidget {
  final String item;

  const GalleryGridItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.file(
          File(item),
          fit: BoxFit.fill,
            cacheHeight: 150,
            cacheWidth: 250
        ),
      ),
    );
  }
}
