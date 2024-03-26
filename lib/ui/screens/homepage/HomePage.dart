import 'dart:io';

import 'package:cheq/ui/screens/homepage/controller/HomeScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/AlbumWithLastImage.dart';
import '../../common/textStyle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AlbumWithLastImage> albumsWithImages = [];

  @override
  void initState() {
    super.initState();

    Get.find<HomeController>().getGalleryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Albums',
              style: CustomTextStyle.of(context)
                  .titleBoldStyle(color: Colors.black)
                  .copyWith(fontSize: 26)),
        ),
        body: GetBuilder<HomeController>(builder: (cont) {
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            itemCount: cont.albumsWithImages.length,
            itemBuilder: (context, index) {
              var item = cont.albumsWithImages[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: item.lastImage.path.toString(),
                      child: Image.file(
                        item.lastImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      color: Colors.black
                          .withOpacity(0.4), // Adjust opacity as needed
                    ),
                    Positioned(
                      bottom: 8.0,
                      left: 8.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: CustomTextStyle.of(context)
                                .titleBoldStyle(color: Colors.white)
                                .copyWith(fontSize: 20),
                          ),
                          Text(
                            "${item.totalImage} Photos",
                            style: CustomTextStyle.of(context)
                                .mediumTitleBoldStyle(color: Colors.white)
                                .copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }));
  }
}

Future<List<AlbumWithLastImage>> fetchAlbumsWithLastImages() async {
  List<AlbumWithLastImage> albumsWithImages = [];

  // Get the external storage directory
  late Directory storageDirectory;

  if (Platform.isAndroid) {
    storageDirectory = Directory('/storage/emulated/0/DCIM');
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

          albumsWithImages.add(AlbumWithLastImage(
              album: entity,
              lastImage: lastImage,
              name: entity.path.split('/').last,
              totalImage: images.length));
        }
      }
    }
  }

  return albumsWithImages;
}
