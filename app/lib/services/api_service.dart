

import 'package:app/config/app_config.dart';

class Api{
  static final String _baseUrl = AppConfig.url;
  /// Auth
  static String login = "$_baseUrl/Login";
  static String auth = "$login/login";
  static String getAllusers = "$login/getAllUser";
}