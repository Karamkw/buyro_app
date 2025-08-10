import 'package:buyro_app/core/constant/routes.dart';
import 'package:buyro_app/data/datasource/remote/app/user/my_favorites_remote.dart';
import 'package:get/get.dart';

abstract class MyFavoriteController extends GetxController {
  fetchMyFavAds();
  goToAddInfo(int adId);
}

class MyFavoriteControllerImp extends MyFavoriteController {
  GetMyFav getMyFav = GetMyFav();

  RxBool isLoading = true.obs;
  RxList<Map<String, dynamic>> myFav = <Map<String, dynamic>>[].obs;

  @override
  Future<void> fetchMyFavAds() async {
    try {
      isLoading.value = true;
      var response = await getMyFav.getData();

      myFav.value = List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print(e);
      Get.snackbar("خطأ", " خطأ أثناء جلب الإعلانات");
      myFav.clear();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchMyFavAds();
  }

  @override
  goToAddInfo(int adId) {
    Get.toNamed(AppRoute.addinfo, arguments: {'adId': adId});
  }
}
