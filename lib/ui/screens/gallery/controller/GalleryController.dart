import 'dart:io';
import 'dart:typed_data';

import 'package:cheq/utils/AlbumService.dart';
import 'package:cheq/utils/galleryHelper.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../models/ImageObj.dart';

class GalleryController extends GetxController implements GetxService {
  List<ImageObj> _galleryImages = [];
  String directoryPath = "";

  List<ImageObj> get galleryImages => _galleryImages;

  getGalleryData(String? path, String name) async {
    if (Platform.isAndroid) {
      directoryPath = path ?? '';
      _galleryImages = await fetchImagesFromDirectoryPaginated(path ?? '', 1);
      update();
    } else {
      // go to ios
      _galleryImages = [];
      var map = await AlbumService.getImagesFromAlbum(name);
      map.forEach((key, value) {
        _galleryImages.add(ImageObj(path: null, uint8list: value));
      });
      update();
    }
  }

  loadMore(int page) async {
    var tempList = await fetchImagesFromDirectoryPaginated(directoryPath, page);
    _galleryImages.addAll(tempList);
    update();
  }

  clearMemory() {
    _galleryImages.clear();
  }
}
