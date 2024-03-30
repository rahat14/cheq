import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class AlbumService {
  static const MethodChannel _channel = MethodChannel('album_channel');

  static Future<List<AlbumData>> getAlbumData() async {
    final  result = await _channel.invokeMethod('getAlbumData') ;
    var m = taskFileUploadRespFromMap(jsonEncode(result));
    return m.data ?? [];
  }

  static Future<Map<String, Uint8List>> getImagesFromAlbum(String albumName) async {
    final  result = await _channel.invokeMethod('getImagesFromAlbum', albumName);

    Map<String, Uint8List> imagesData = {};
    result['data'].forEach((key, value) {
      imagesData[key as String] = base64Decode(value as String);
    });


    return imagesData;
  }
}

class AlbumData {
  final String name;
  final Uint8List image;
  final int count ;

  AlbumData({required this.name, required this.image , required this.count});

  factory AlbumData.fromMap(Map<String, dynamic> json) => AlbumData(
    image:  base64Decode(json['image'] as String),
    name: json["name"],
    count : json["count"],

  );

  factory AlbumData.fromJson(Map<String, dynamic> json) {
    return AlbumData(
      name: json['name'] as String,
      image: base64Decode(json['image'] as String),
      count: json['count'] as int,
    );
  }
}

TaskFileUploadResp taskFileUploadRespFromMap(String str) => TaskFileUploadResp.fromMap(json.decode(str));
class TaskFileUploadResp {
  List<AlbumData>? data;

  TaskFileUploadResp({
    this.data,
  });

  factory TaskFileUploadResp.fromMap(Map<String, dynamic> json) => TaskFileUploadResp(
    data: json["data"] == null ? [] : List<AlbumData>.from(json["data"]!.map((x) => AlbumData.fromMap(x))),
  );

}


