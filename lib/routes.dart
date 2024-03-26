import 'package:cheq/ui/screens/PremissionScreen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AllRoutes {
  static const String splashScreen = '/splash';
  static const String home = '/';
  static const String permissionScreen = '/permissionScreen';
  static const String dashboard = '/';



  static String getSplashRoute() => splashScreen;




  static List<GetPage> routes = [
    GetPage(name: permissionScreen, page: () => const PermissionScreen()),


  ];
}