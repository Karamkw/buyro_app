import 'package:get/get.dart';

class NotificationsController extends GetxController {
  RxBool isLoading = true.obs;
  List<Map<String, dynamic>> notifications = [];

  @override
  void onInit() {
    super.onInit();
    fetchNotifications(); // جلب البيانات عند فتح الصفحة
  }

  void fetchNotifications() async {
    isLoading.value = true;

    // TODO: استبدل هذا بالقيمة الحقيقية من API
    await Future.delayed(const Duration(seconds: 1));

    // هذا فقط مؤقت للتجربة
    notifications = [
      {
        "title": "إعلانك حصل على إعجاب جديد!",
        "body": "قام أحمد بالإعجاب بإعلانك 'موبايل سامسونج'.",
        "date": "منذ 1 ساعة"
      },
      {
        "title": "تمت الموافقة على إعلانك",
        "body": "إعلانك 'لابتوب جديد للبيع' تمت الموافقة عليه.",
        "date": "منذ 3 ساعات"
      },
    ];

    isLoading.value = false;
    update();
  }
}
