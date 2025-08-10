import 'package:buyro_app/view/screen/other/favorite.dart';
import 'package:buyro_app/view/screen/home/home.dart';
import 'package:buyro_app/view/screen/other/myaccount.dart';
import 'package:buyro_app/view/screen/other/myadds.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buyro_app/controller/other/navigation_controller.dart';
import 'package:buyro_app/core/constant/color.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainNavigationController());

    final pages = [
      const HomePage(),
      const FavoritePage(),
      const MyAcountPage(),
      const MyAddsPage(),
    ];

    return Obx(
      () => Scaffold(
        body: pages[controller.currentPageIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentPageIndex.value,
          onTap: controller.changePage,
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "المفضلة",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: "إعلاناتي",
            ),
          ],
        ),
      ),
    );
  }
}
