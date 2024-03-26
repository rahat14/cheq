import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'TestFile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cheq Test',
      home: const Placeholder(),
      debugShowCheckedModeBanner: false,
      transitionDuration: const Duration(milliseconds: 500),
      navigatorKey: Get.key,
      defaultTransition: Transition.topLevel,
    );
  }
}
