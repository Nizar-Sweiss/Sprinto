import 'package:flutter/cupertino.dart';

import '../config/colors.dart';
import '../utils/Popups.dart';

class RequestHandler {
  static void successRequest(BuildContext context, {String message = "Success"}) {
    PopUps.showSnackBar(context, success, message);
  }

  static void warningRequest(BuildContext context, {String message = "Warning"}) {
    PopUps.showSnackBar(context, warning, message);
  }

  static void errorRequest(BuildContext context, {String message = "Error"}) {
    PopUps.showSnackBar(context, error, message);
  }
}