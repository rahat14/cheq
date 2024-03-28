import 'package:flutter/material.dart';

import '../../../../models/AlbumWithLastImage.dart';
import '../../../common/textStyle.dart';

class HomePageGridItem extends StatelessWidget {
  final AlbumWithLastImage item;

  const HomePageGridItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    print(item.album.path);
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            item.lastImage,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.4), // Adjust opacity as needed
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
  }
}
