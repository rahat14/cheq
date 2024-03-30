import 'dart:io';
import 'dart:typed_data';

class AlbumWithLastImage {
  late Directory? album;
  late Uint8List lastImage;
  late int totalImage;
  late String name;

  AlbumWithLastImage(
      {required this.album,
      required this.lastImage,
      required this.totalImage,
      required this.name});
}
