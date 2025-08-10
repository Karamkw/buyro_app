import 'package:buyro_app/controller/auth/checkcode_controller.dart';
import 'package:buyro_app/core/constant/routes.dart';
import 'package:buyro_app/data/datasource/remote/auth/forgetpassword_remote.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class ForgetPasswordController extends GetxController {
  checkemail();
}

class ForgetPasswordControllerImp extends ForgetPasswordController {
  late TextEditingController email;
  ForgetPasswordRemote forgetPasswordRemote = ForgetPasswordRemote();
  @override
  checkemail() async {
    final response = await forgetPasswordRemote.postData(email: email.text);
    print(response.body);

    if (response.statusCode == 200) {
      Get.offNamed(
        AppRoute.checkCode,
        arguments: {'type': CheckCodeType.forgetpassword, 'email': email.text},
      );
    } else {
      Get.snackbar("فشل", "حدث خطأ ");
    }
  }

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
