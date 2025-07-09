import 'package:app/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/colors.dart';

class PopUps{
  static void showSnackBar(BuildContext context, Color color, String message){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: color,
            content: Text(
              message,
              style: const TextStyle(
                  color: Colors.white
              ),
            )
        )
    );
  }

  static Future<bool?> askDialog(
      Widget icon,
      String title, String subTitle,
      [String cancelTxt = "", String yesTxt = ""]) async {
    return Get.dialog(
        AlertDialog(
          content: SizedBox(
            height: 150,
            width: 300,
            child: Column(
              children: [
                icon,
                5.ph,
                const Divider(),
                const Expanded(child: SizedBox(),),
                Center(
                  child: Text(
                    title,
                    style: kButtonTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Expanded(child: SizedBox(),),
                Padding(
                  padding: kPadding(16, 8),
                  child: Center(
                    child: Text(
                        subTitle,
                        style: kButtonTextStyle,
                        textAlign: TextAlign.center
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                onPressed: (){
                  Get.back();
                },
                child: Text(cancelTxt == "" ? "Cancel".tr : cancelTxt)
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                ),
                onPressed: (){
                  Get.back(result: true);
                },
                child: Text(yesTxt == "" ? "Yes".tr : yesTxt)
            ),
          ],
        )
    );
  }

}