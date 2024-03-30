import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

import '../models/ImageObj.dart';

Future<List<String>> fetchImagesFromDirectory(
    String directoryPath, int page) async {
  List<String> imageBytesList = [];

  late Directory directory = Directory(directoryPath);

  if (await directory.exists()) {
    List<FileSystemEntity> entities = directory.listSync(followLinks: false);

    // Calculate start and end indices based on page and pageSize
    int start = page == 1 ? 0 : page * 48;
    int end = (page + 1) * 48;

    for (int i = start; i < end && i < entities.length; i++) {
      FileSystemEntity entity = entities[i];

      if (entity is File &&
          (entity.path.toLowerCase().endsWith('.jpg') ||
              entity.path.toLowerCase().endsWith('.png') ||
              entity.path.toLowerCase().endsWith('.jpeg'))) {
        imageBytesList.add(entity.path);
      }
    }
  } else {
    debugPrint("does not exits");
  }

  return imageBytesList;
}

Future<List<ImageObj>> fetchImagesFromDirectoryPaginated(
    String directoryPath, int page) async {
  List<ImageObj> imageBytesList = [];

  late Directory directory = Directory(directoryPath);

  if (await directory.exists()) {
    List<FileSystemEntity> entities = directory.listSync(followLinks: false);

    // Calculate start and end indices based on page and pageSize
    int start = page == 1 ? 0 : page * 48;
    int end = (page + 1) * 48;

    for (int i = start; i < end && i < entities.length; i++) {
      FileSystemEntity entity = entities[i];

      if (entity is File &&
          (entity.path.toLowerCase().endsWith('.jpg') ||
              entity.path.toLowerCase().endsWith('.png') ||
              entity.path.toLowerCase().endsWith('.jpeg'))) {
        var model = ImageObj(path: entity.path, uint8list: null);
        imageBytesList.add(model);
      }
    }
  } else {
    debugPrint("erm");
  }

  return imageBytesList;
}

Uint8List fileToUint8List(File file) {
  List<int> imageBytes = file.readAsBytesSync();
  return Uint8List.fromList(imageBytes);
}
