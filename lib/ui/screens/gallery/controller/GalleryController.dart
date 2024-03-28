import 'dart:io';

import 'package:cheq/utils/galleryHelper.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class GalleryController extends GetxController implements GetxService {
  List<String> _galleryImages = [];
  String directoryPath = "" ;
  List<String> get galleryImages => _galleryImages;

  getGalleryData(String path) async {
    directoryPath = path ;

    if (Platform.isAndroid) {
      _galleryImages = await fetchImagesFromDirectory(path , 1 );
      update();
    } else {
      // go to ios
    }
  }

  loadMore(int page) async {
    var tempList = await fetchImagesFromDirectory(directoryPath , page );
    _galleryImages.addAll(tempList);
    update();
  }
}
