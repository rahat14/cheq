import 'dart:convert';

import 'package:flutter/services.dart';

class AlbumService {
  static const MethodChannel _channel = MethodChannel('album_channel');

  static Future<List<AlbumData>> getAlbumData() async {
    final  result = await _channel.invokeMethod('getAlbumData') ;
    var m = taskFileUploadRespFromMap(jsonEncode(result));
    return m.data ?? [];
  }
}

class AlbumData {
  final String name;
  final Uint8List image;

  AlbumData({required this.name, required this.image});

  factory AlbumData.fromMap(Map<String, dynamic> json) => AlbumData(
    image:  base64Decode(json['image'] as String),
    name: json["name"],
  );

  factory AlbumData.fromJson(Map<String, dynamic> json) {
    return AlbumData(
      name: json['name'] as String,
      image: base64Decode(json['image'] as String),
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
