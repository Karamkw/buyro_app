import 'package:buyro_app/controller/other/navigation_controller.dart';
import 'package:buyro_app/core/constant/routes.dart';
import 'package:buyro_app/data/datasource/remote/app/user/profile_remote.dart';
import 'package:buyro_app/data/datasource/remote/auth/resendcode_reomte.dart';
import 'package:buyro_app/data/datasource/remote/auth/verifycode_remote.dart';
//import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum VerifyCodeType { signUp, login }

abstract class VerifyCodeController extends GetxController {
  checkCode();
  resendCode();
}

class VerifyCodeControllerImp extends VerifyCodeController {
  final VerifyCodeType type;
  final String email;
  String code = '';
  GetUserInfo getUserInfo = GetUserInfo();
  final VerifyCodeRemote _remote = VerifyCodeRemote();
  final ResendCodeRemote _resend = ResendCodeRemote();
  VerifyCodeControllerImp({required this.type, required this.email});

  @override
  Future<void> checkCode() async {
    final token = await _remote.checkCodeAndGetToken(email: email, code: code);

    if (token != null) {
      switch (type) {
        case VerifyCodeType.signUp:
          Get.offAllNamed(AppRoute.login);
          break;

        case VerifyCodeType.login:
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("user_token", token);

          var data = await getUserInfo.getData();
          final currentUserId = data['id'];
          await prefs.setInt("current_user_id", currentUserId);

          final mainPageController = Get.put(MainNavigationController());
          mainPageController.changePage(0);
          Get.offAllNamed(AppRoute.mainpage);
          break;
      }
    } else {
      Get.snackbar("خطأ", "رمز التحقق غير صحيح");
    }
  }

  @override
  resendCode() async {
    final response = await _resend.postData(email: email);
    print(response.body);

    if (response.statusCode == 200) {
      Get.snackbar("نجاح", "تم ارسال الكود بنجاح ");
    } else {
      Get.snackbar("فشل", "حدث خطأ ");
    }
  }
}
