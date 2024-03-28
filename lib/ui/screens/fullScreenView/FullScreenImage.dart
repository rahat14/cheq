import 'dart:io';

import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  final String link;
  final File file;
  const FullScreenImage({super.key, required this.link , required this.file});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.link,
      child: Container(
        color: Colors.black,
        child: Image.file(
         widget.file,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
