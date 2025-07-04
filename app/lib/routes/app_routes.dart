import 'package:get/get.dart';
import '../screens/index.dart';
class AppRoutes {
  static const login = '/login';
  static const home = '/home';

  static final routes = [
    GetPage(
      name: login,
      page: () =>  LoginScreen(),
    ),

  ];
}