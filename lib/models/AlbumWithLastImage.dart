import 'dart:io';

class AlbumWithLastImage {
  late Directory album;
  late File lastImage;
  late int totalImage;

  late String name;

  AlbumWithLastImage(
      {required this.album,
      required this.lastImage,
      required this.totalImage,
      required this.name});
}
