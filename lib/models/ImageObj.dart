import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

class ImageObj  {
  String? path;
  Uint8List? uint8list;

  ImageObj({required this.path, required this.uint8list});

  File get file =>   File(path ?? '');
}