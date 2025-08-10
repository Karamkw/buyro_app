import 'package:buyro_app/data/datasource/remote/app/adds/like_fav_ad_remote.dart';
import 'package:buyro_app/data/datasource/remote/app/adds/report_rating_remote.dart';
import 'package:get/get.dart';
import 'package:buyro_app/data/datasource/remote/app/adds/ad_info_remote.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buyro_app/controller/home/home_controller.dart';
import 'package:buyro_app/core/constant/routes.dart';
import 'package:buyro_app/data/datasource/remote/app/adds/delete_update_ad_remote.dart';

class AddInfoController extends GetxController {
  AddInofrmation addInfoRemote = AddInofrmation();
  LikeAndFavAd likeAndFavAdd = LikeAndFavAd();
  DeleteAndUpdateAd deleteAndUpdateAd = DeleteAndUpdateAd();
  ReportAndRate reportAndRate = ReportAndRate();

  Map<String, dynamic>? adDetails;
  bool isLoading = true;
  RxBool isLiked = false.obs;
  RxBool isFavorited = false.obs;
  int? currentUserId;

  Future<void> fetchAdDetails(String adId) async {
    await loadCurrentUserId();
    try {
      final data = await addInfoRemote.getData(adId);
      adDetails = data;

      // ضبط الحالات بناءً على القيم من الباك
      isLiked.value = adDetails?['is_liked'] ?? false;
      isFavorited.value = adDetails?['is_favourite'] ?? false;

      print(data);
    } catch (e) {
      Get.snackbar('خطأ', 'تعذر جلب بيانات الإعلان: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> loadCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    currentUserId = prefs.getInt("current_user_id");
  }

  toggleLike(String adId) async {
    isLiked.value = !isLiked.value;
    final response = await likeAndFavAdd.likead(adid: adId);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.body);
      Get.snackbar('فشل', 'فشلت العملية يرجى اعادة المحاولة');
    }
  }

  removeLike(String adId) async {
    isLiked.value = !isLiked.value;
    final response = await likeAndFavAdd.removelikead(adid: adId);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.body);
      Get.snackbar('فشل', 'فشلت العملية يرجى اعادة المحاولة');
    }
  }

  toggleFavorite(String adId) async {
    isFavorited.value = !isFavorited.value;
    final response = await likeAndFavAdd.favad(adid: adId);
    if (response.statusCode == 200) {
      print(response.body);
      Get.snackbar('نجاح', 'تم اضافة العنصر إلى المفضلة بنجاح');
    } else {
      print(response.body);
      Get.snackbar('فشل', 'فشلت العملية يرجى اعادة المحاولة');
    }
  }

  removeFavorite(String adId) async {
    isFavorited.value = !isFavorited.value;
    final response = await likeAndFavAdd.removefavad(adid: adId);
    if (response.statusCode == 200) {
      print(response.body);
      Get.snackbar('نجاح', 'تم ازلة العنصر من المفضلة ');
    } else {
      print(response.body);
      Get.snackbar('فشل', 'فشلت العملية يرجى اعادة المحاولة');
    }
  }

  deleteAd(String adid) async {
    final response = await deleteAndUpdateAd.deletead(adid: adid);
    if (response.statusCode == 200) {
      print(response.body);
      Get.snackbar('نجاح', 'تم حذف الاعلان');
      if (Get.isRegistered<HomeControllerImp>()) {
        Get.delete<HomeControllerImp>();
      }
      Get.offAllNamed(AppRoute.mainpage);
      Get.delete<AddInfoController>();
    } else {
      print(response.body);
      Get.snackbar('فشل', 'فشلت العملية يرجى اعادة المحاولة');
    }
  }

  reportAd({
    required String adId,
    required String reason,
    String? content,
  }) async {
    final body = {"adv_id": adId, "type": reason};

    if (reason == "other" && content != null && content.isNotEmpty) {
      body["content"] = content;
    }
    final response = await reportAndRate.reportad(body: body);

    if (response.statusCode == 200) {
      Get.snackbar('نجاح', 'تم إرسال الإبلاغ بنجاح');
    } else {
      Get.snackbar('فشل', 'فشلت عملية الإبلاغ');
    }
  }

  ratingAd({
    required String adId,
    required String rating,
    String? comment,
  }) async {
    final body = {"adv_id": adId, "rating": rating};

    if (comment != null && comment.isNotEmpty) {
      body["comment"] = comment;
    }
    final response = await reportAndRate.ratingadd(body: body);

    if (response.statusCode == 200) {
      Get.snackbar('نجاح', 'تم إرسال تقييمك بنجاح');
    } else {
      Get.snackbar('فشل', 'فشلت عملية التقييم');
    }
  }
}
