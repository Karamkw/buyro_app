import 'package:buyro_app/core/constant/routes.dart';
import 'package:buyro_app/data/datasource/remote/auth/resetpassword_reomte.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ChangePasswordController extends GetxController {
  resetpassword();
}

class ChangePasswordControllerImp extends ChangePasswordController {
  final String token;
  late TextEditingController password;
  late TextEditingController repassword;
  ChangePasswordControllerImp({required this.token});
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  ResetePasswordRemote reset = ResetePasswordRemote();

  @override
  resetpassword() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      final response = await reset.postData(
        password: password.text,
        repassword: repassword.text,
        token: token,
      );
      print(response.body);

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("user_token",token);
         Get.snackbar("نجاح", " تم تغيير كلمة المرور بنجاح");
        Get.offNamed(AppRoute.mainpage);
          Get.delete<ChangePasswordControllerImp>();
      } else {
        Get.snackbar("فشل", "حدث خطأ");
      }
    } else {
    }
  }

  @override
  void onInit() {
    password = TextEditingController();
    repassword = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    password.dispose();
    repassword.dispose();
    super.dispose();
  }
}
