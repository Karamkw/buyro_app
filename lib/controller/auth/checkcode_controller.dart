import 'package:buyro_app/core/constant/routes.dart';
import 'package:buyro_app/data/datasource/remote/auth/checkcodeforreset_remote.dart';
import 'package:buyro_app/data/datasource/remote/auth/resendcode_reomte.dart';
import 'package:get/get.dart';


enum CheckCodeType {forgetpassword, profile }
abstract class CheckCodeController extends GetxController {
  checkCoderesetpassword();
  resendCode();
}

class CheckCodeControllerImp extends CheckCodeController {
  final CheckCodeType type;
  final String email;
  String code = '';

  final CheckCodeForResetRemote _remote = CheckCodeForResetRemote();
  final ResendCodeRemote _resend = ResendCodeRemote();
  CheckCodeControllerImp({required this.type,required this.email});

  @override
  Future<void> checkCoderesetpassword() async {
    final token = await _remote.checkCodeForReset(email: email, code: code);
    if (token != null) {
 switch (type) {
        case CheckCodeType.forgetpassword:
          Get.offAllNamed(AppRoute.resetPassword, arguments: {'token': token});
          break;

        case CheckCodeType.profile:
          Get.offAllNamed(AppRoute.changePassword, arguments: {'token': token});
          break;
      }
    } else {
      Get.snackbar("خطأ", "رمز التحقق غير صحيح");
    }
  }
  
  @override
  resendCode() async{
   final response = await _resend.postData(email: email);
     //print(response.body);

    if (response.statusCode == 200) {
       Get.snackbar("نجاح", "تم ارسال الكود بنجاح ");
    } else {
      Get.snackbar("فشل", "حدث خطأ ");
    }
  }
}
