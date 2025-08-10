import 'package:buyro_app/core/constant/routes.dart';
import 'package:buyro_app/data/datasource/remote/auth/resetpassword_reomte.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class ResetPasswordController extends GetxController {
  resetpassword();
}

class ResetPasswordControllerImp extends ResetPasswordController {
  final String token;
  late TextEditingController password;
  late TextEditingController repassword;
  ResetPasswordControllerImp({required this.token});
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
        Get.offNamed(AppRoute.successResetpassword);
        Get.delete<ResetPasswordControllerImp>();
      } else {
        Get.snackbar("فشل", "حدث خطأ");
      }
    } else {
      print("Not Valid");
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
