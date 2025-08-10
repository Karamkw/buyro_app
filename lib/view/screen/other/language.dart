import 'package:buyro_app/core/constant/routes.dart';
import 'package:buyro_app/core/localization/changelocal.dart';
import 'package:buyro_app/view/widget/language/custombuttomlang.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Language extends GetView<LocaleController> {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("1".tr, style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 20),
            CustomButtonLang(
              textbutton: "العربية",
              onPressed: () {
                controller.changeLang("ar");
                Get.offNamed(AppRoute.mainpage);
              },
            ),
            CustomButtonLang(
              textbutton: "English",
              onPressed: () {
                controller.changeLang("en");
                Get.offNamed(AppRoute.mainpage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
