import 'package:cheq/ui/screens/PremissionScreen.dart';
import 'package:cheq/ui/screens/homepage/HomePage.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AllRoutes {
  static const String splashScreen = '/splash';
  static const String home = '/home';
  static const String permissionScreen =    '/permissionScreen';
  static const String dashboard = '/';

  static String getSplashRoute() => splashScreen;

  static String getHomeRoute() => home;


  static List<GetPage> routes = [
    GetPage(name: permissionScreen, page: () => const PermissionScreen()),
    GetPage(name: home, page: () => const HomePage()),

  ];
}