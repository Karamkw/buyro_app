import 'package:buyro_app/data/datasource/remote/app/adds/get_ads_remote.dart';
import 'package:buyro_app/data/datasource/remote/auth/logout_remote.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buyro_app/core/constant/routes.dart';

abstract class HomeController extends GetxController {
  fetchAds();
  goToAddad();
  goToserch();
  logout();
  goToAddInfo(int adId);
}

class HomeControllerImp extends HomeController {
  LogoutRemote logoutRemote = LogoutRemote();
  GetProducts getProducts = GetProducts();
  List products = [];
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    fetchAds(); 
  }

  @override
  Future<void> fetchAds() async {
    try {
      products = await getProducts.getData();
    } catch (e) {
      print("خطأ بجلب المنتجات: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  goToAddad() {
    Get.toNamed(AppRoute.addad);

  }

  @override
  logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("user_token").toString();
    // prefs.clear();
    final response = await logoutRemote.deletetoken(token: token);
    if (response.statusCode == 200) {
      print(token);
      Get.offAllNamed(AppRoute.login);
    } else {
      print(response.body);
    }
  }

  @override
  goToserch() {
    Get.toNamed(AppRoute.search);
  }

  @override
  goToAddInfo(int adId) {
    Get.toNamed(AppRoute.addinfo, arguments: {'adId': adId});
  }
}
