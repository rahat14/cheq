import 'package:cheq/ui/screens/PremissionScreen.dart';
import 'package:cheq/ui/screens/gallery/controller/GalleryController.dart';
import 'package:cheq/ui/screens/homepage/controller/HomeScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'ui/screens/homepage/HomePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => GalleryController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cheq Test',
      debugShowCheckedModeBanner: false,
      transitionDuration: const Duration(milliseconds: 500),
      navigatorKey: Get.key,
      defaultTransition: Transition.topLevel,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: FutureBuilder<bool>(
        future: isPermissionAccepted(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == true) {
            return const HomePage();
          } else {
            return const PermissionScreen();
          }
        },
      ),
    );
  }
}

Future<bool> isPermissionAccepted() async {
  var permissionState = await Permission.photos.status;
  return permissionState == PermissionStatus.granted;
}
