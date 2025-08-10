import 'package:buyro_app/core/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class LocaleController extends GetxController {
  Locale? language;
  MyServices myServices = Get.find();

  // تغيير اللغة وتخزينها
  changeLang(String langcode) {
    Locale locale = Locale(langcode);
    myServices.sharedPreferences.setString("lang", langcode);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? savedLang = myServices.sharedPreferences.getString("lang");

    if (savedLang != null) {
      // إذا كان في لغة محفوظة، استخدمها
      language = Locale(savedLang);
    } else {
      // أول مرة، استخدم لغة الجهاز إذا كانت ar أو en
      String deviceLang = Get.deviceLocale?.languageCode ?? 'en';
      if (["ar", "en"].contains(deviceLang)) {
        language = Locale(deviceLang);
      } else {
        language = const Locale("en"); // fallback
      }

      // واحفظ اللغة المختارة تلقائيًا للمرة الجاية
      myServices.sharedPreferences.setString("lang", language!.languageCode);
    }

    super.onInit();
  }
}
