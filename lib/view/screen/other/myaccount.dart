import 'package:buyro_app/view/screen/other/profile.dart';
import 'package:buyro_app/view/widget/app/account_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buyro_app/view/screen/other/language.dart';
import 'package:buyro_app/controller/home/home_controller.dart';

class MyAcountPage extends StatelessWidget {
  const MyAcountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeControllerImp controller = Get.put(HomeControllerImp());

    return Scaffold(
      appBar: AppBar(
        title: const Text("حسابي"),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          children: [
            AccountMenuItem(
              icon: Icons.language,
              label: "تغيير اللغة",
              onTap: () => Get.to(() => const Language()),
            ),
            const SizedBox(height: 20),

            AccountMenuItem(
              icon: Icons.person,
              label: "الملف الشخصي",
              onTap: () => Get.to(() => const ProfilePage()),
            ),
            const SizedBox(height: 20),

            AccountMenuItem(
              icon: Icons.info_outline,
              label: "عن التطبيق",
              onTap: () {
                Get.defaultDialog(
                  title: "حول التطبيق",
                  middleText:
                      "Buyro - تطبيق للبيع والشراء ضمن سوريا.\nالإصدار 1.0",
                );
              },
            ),
            const SizedBox(height: 20),

            AccountMenuItem(
              icon: Icons.logout,
              label: "تسجيل الخروج",
              color: Colors.red,
              onTap: () => controller.logout(),
            ),
          ],
        ),
      ),
    );
  }
}
