import 'dart:io';

import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../models/AlbumWithLastImage.dart';
import '../../../../utils/AlbumService.dart';

class HomeController extends GetxController implements GetxService {
  late Directory storageDirectory;

  List<AlbumWithLastImage> _albumsWithImages = [];

  List<AlbumWithLastImage> get albumsWithImages => _albumsWithImages;

  getGalleryData() {
    if (Platform.isAndroid) {
      fetchAlbumsWithLastImages();
    } else {
      // go to ios
    }
  }

  fetchAlbumsWithLastImages() async {
    List<AlbumWithLastImage> albumsWithImage = [];
    // Get the external storage directory
    if (Platform.isAndroid) {
      storageDirectory = Directory(
        '/storage/emulated/0/DCIM',
      );
    } else if (Platform.isIOS) {
      storageDirectory = Directory('/DCIM');
    } else {
      throw UnsupportedError('Unsupported platform');
    }

    if (await storageDirectory.exists()) {
      // List all directories in the DCIM directory
      List<FileSystemEntity> entities =
          storageDirectory.listSync(followLinks: false);

      for (FileSystemEntity entity in entities) {
        if (entity is Directory) {
          List<FileSystemEntity> albumContents =
              entity.listSync(followLinks: false);

          // Filter out directories and get only image files
          List<File> images =
              albumContents.whereType<File>().cast<File>().toList();

          if (images.isNotEmpty) {
            // Sort images by last modified date and get the last one
            images.sort(
                (a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));
            File lastImage = images.first;

            albumsWithImage.add(AlbumWithLastImage(
                album: entity,
                lastImage: lastImage,
                name: entity.path.split('/').last,
                totalImage: images.length));
          }
        }
      }
    }

    _albumsWithImages = albumsWithImage;
    update();
  }


  // Future<void> _fetchIosAlbumNames() async {
  //   List<AlbumWithLastImage> tempList = [];
  //   try {
  //     var albumData = await AlbumService.getAlbumData();
  //
  //     for (AlbumData item in albumData) {
  //       tempList.add(AlbumWithLastImage(
  //           name: item.name, image: item.image, album: null, lastImage: null, totalImage: null));
  //     }
  //
  //     setState(() {
  //       albumsWithImages = tempList;
  //     });
  //   } catch (e) {
  //     print("Failed to get album names: $e");
  //   }
  // }


 Future<bool> permissionStatus()async{
    var status = await Permission.camera.status;
    return status == PermissionStatus.granted ;
  }
}
