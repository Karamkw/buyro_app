import 'package:buyro_app/controller/auth/checkcode_controller.dart';
import 'package:buyro_app/core/constant/routes.dart';
import 'package:buyro_app/data/datasource/remote/app/user/profile_remote.dart';
import 'package:buyro_app/data/datasource/remote/auth/forgetpassword_remote.dart';
import 'package:get/get.dart';

abstract class ProfileController extends GetxController {
  fetchUserInfo();
  goToCheckCode(String email);
}

class ProfileControllerImp extends ProfileController {
  GetUserInfo getUserInfo = GetUserInfo();

  RxBool isLoading = true.obs;
  RxMap<String, dynamic> userData = <String, dynamic>{}.obs;

  @override
  Future<void> fetchUserInfo() async {
    try {
      isLoading.value = true;
      var data = await getUserInfo.getData();
      userData.value = data;
    } catch (e) {
      Get.snackbar("خطأ", "فشل في جلب معلومات المستخدم");
      userData.clear();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  goToCheckCode(String email) {
    ForgetPasswordRemote sendcode = ForgetPasswordRemote();
    sendcode.postData(email: email);
    Get.offNamed(
      AppRoute.checkCode,
      arguments: {'type': CheckCodeType.profile, 'email': email},
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
  }
}
