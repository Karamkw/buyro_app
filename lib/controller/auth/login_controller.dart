import 'package:buyro_app/controller/auth/verifycode_controller.dart';
import 'package:buyro_app/core/constant/routes.dart';
import 'package:buyro_app/data/datasource/remote/auth/signin_remote.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  goToForgetPassword();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;
  SignInRemote signInRemote = SignInRemote();
  bool isshowpassword = true;

  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  @override
  login() async {
     var formdata = formstate.currentState;
    if (formdata!.validate()) {
      final response = await signInRemote.postData(
      email: email.text,
      password: password.text,
    );
    print(response.body);

    if (response.statusCode == 200) {
      
      Get.offNamed(
        AppRoute.verfiyCode,
        arguments: {'type': VerifyCodeType.login, 'email': email.text},
      );
       Get.delete<LoginControllerImp>();
    } else {
      Get.snackbar("فشل", "حدث خطأ أثناء تسجيل الدخول");
    }
    } else {
      print("Not Valid");
    }
    
  }

  @override
  goToSignUp() {
    Get.offNamed(AppRoute.signUp);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }
}
