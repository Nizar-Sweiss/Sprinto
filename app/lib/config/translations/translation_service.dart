import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'ar_jo.dart';
import 'en_jo.dart';

class TranslationService extends Translations {

  static void changeLocale(){
    if(Get.locale!.languageCode == 'en'){
      Get.updateLocale(const Locale('ar'));
    }else{
      Get.updateLocale(const Locale('en'));
    }
  }

  @override
  Map<String, Map<String, String>> get keys => {
    'en': English.english,
    'ar': Arabic.arabic,
  };
}