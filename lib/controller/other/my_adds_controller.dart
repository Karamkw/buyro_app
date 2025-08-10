import 'package:buyro_app/core/constant/routes.dart';
import 'package:buyro_app/data/datasource/remote/app/user/my_ads_remote.dart';
import 'package:get/get.dart';

abstract class MyAddsController extends GetxController {
  fetchMyAds();
  goToAddInfo(int adId);
}

class MyAddsControllerImp extends MyAddsController {
  GetMyAds getMyAdds = GetMyAds();

  RxBool isLoading = true.obs;
  RxList<Map<String, dynamic>> myAds = <Map<String, dynamic>>[].obs;

  @override
  Future<void> fetchMyAds() async {
    try {
      isLoading.value = true;

      var response = await getMyAdds.getData();
      print(response);
      // ✅ تعبئة القائمة مع التحويل للنوع الصحيح
      myAds.value = List<Map<String, dynamic>>.from(response);
    } catch (e) {
      Get.snackbar("خطأ", "صار خطأ أثناء جلب الإعلانات");
      myAds.clear();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchMyAds(); // أول ما تفتح الصفحة
  }

  @override
  goToAddInfo(int adId) {
    Get.toNamed(AppRoute.addinfo, arguments: {'adId': adId});
  }
}
