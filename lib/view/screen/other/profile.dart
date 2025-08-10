import 'package:buyro_app/controller/other/profile_controler.dart';
import 'package:buyro_app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileControllerImp());

    return Scaffold(
      appBar: AppBar(title: const Text("حسابي")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.userData.isEmpty) {
          return const Center(child: Text("لا توجد بيانات مستخدم"));
        }
        final name = controller.userData['name'] ?? '';
        final email = controller.userData['email'] ?? '';
        final firstLetter = name.isNotEmpty ? name[0].toUpperCase() : '?';

        return Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: AppColor.primaryColor,
                  child: Text(
                    firstLetter,
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  email,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 200),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.defaultDialog(
                      middleText:
                          "سيتم ارسال كود تحقق الى الايميل لتغيير كلمة المرور ",
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            controller.goToCheckCode(
                              controller.userData['email'],
                            );
                          },
                          child: const Text("تاكيد"),
                        ),
                        SizedBox(width: 50),
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("الغاء"),
                        ),
                      ],
                    );
                  },
                  icon: const Icon(Icons.lock, color: Colors.black),
                  label: const Text(
                    "تغيير كلمة المرور",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
