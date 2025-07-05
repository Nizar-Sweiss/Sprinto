
import 'package:app/screens/home/index.dart';
import 'package:app/screens/project_details/index.dart';
import 'package:get/get.dart';
import '../screens/login/index.dart';
class AppRoutes {
  static const login = '/login';
  static const home = '/home';
  static const projectDetails = '/projectDetails';
  static final routes = [
    GetPage(
      name: login,
      page: () =>  LoginScreen(),
    ),
    GetPage(
      name: home,
      page: () =>  HomeScreen(),
    ),
    GetPage(
      name: projectDetails,
      page: () =>  ProjectDetailsScreen(),
    ),
  ];

}