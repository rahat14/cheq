import 'package:cheq/ui/screens/PremissionScreen.dart';
import 'package:cheq/ui/screens/homepage/controller/HomeScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ui/screens/homepage/HomePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => HomeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cheq Test',
      home: const PermissionScreen(),
      debugShowCheckedModeBanner: false,
      transitionDuration: const Duration(milliseconds: 500),
      navigatorKey: Get.key,
      defaultTransition: Transition.topLevel,
      theme: ThemeData(fontFamily: 'Roboto'),
    );
  }
}
