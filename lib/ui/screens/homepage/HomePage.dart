import 'package:cheq/ui/screens/homepage/controller/HomeScreenController.dart';
import 'package:cheq/ui/screens/homepage/widget/HomeGridItem.dart';
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
              var album = cont.albumsWithImages[index];
              return HomePageGridItem(
                item: album,
              );
            },
          );
        }));
  }
}
