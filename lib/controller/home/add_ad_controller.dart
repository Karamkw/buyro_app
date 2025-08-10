import 'package:buyro_app/controller/home/home_controller.dart';
import 'package:buyro_app/core/constant/routes.dart';
import 'package:buyro_app/data/datasource/remote/app/adds/add_ad_remote.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddAdController extends GetxController {

  final priceController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
    final phoneController = TextEditingController();
  final RxInt selectedCategoryId = 0.obs;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  AddAdRemote addAdRemote = AddAdRemote();

  final categories = [
    {'id': 1, 'name': 'سيارات'},
    {'id': 2, 'name': 'موبايلات'},
    {'id': 3, 'name': 'أثاث'},
  ];

  void submitAd() async {
    final price = priceController.text.trim();
    final location = locationController.text.trim();
    final description = descriptionController.text.trim();
    final phone = phoneController.text.trim();
    final adData = {
      'price': price,
      'location': location,
      'description': description,
      'category_id': selectedCategoryId.value,
      'phone':phone
    };
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      final response = await addAdRemote.postData(body: adData);
      //print(response.body);

      if (response.statusCode == 200) {
        Get.snackbar("نجاح", "تم نشر الإعلان بنجاح");
        
    if (Get.isRegistered<HomeControllerImp>()) {
    Get.delete<HomeControllerImp>();
  }

        Get.offNamed(AppRoute.mainpage);
        Get.delete<AddAdController>();
      } else {
        Get.snackbar("فشل", "حدث خطأ أثناء إنشاء الاعلان");
      }
    } else {}
  }

  // @override
  // void onClose() {
  //   priceController.dispose();
  //   locationController.dispose();
  //   descriptionController.dispose();
  //   super.onClose();
  // }
}
