import 'dart:async';
import 'dart:convert';
import 'package:buyro_app/core/constant/routes.dart';
import 'package:buyro_app/data/datasource/remote/app/search_remote.dart';
import 'package:get/get.dart';

class SearchControllerP extends GetxController {
  SearchAdd searchAdd = SearchAdd();
  // خيارات الفلترة
  final RxBool useDescription = false.obs;
  final RxBool useLocation = false.obs;
  final RxBool usePrice = false.obs;
  final RxBool useCategory = false.obs;

  // القيم المدخلة من المستخدم
  final RxString searchValue = ''.obs;
  final RxString locationValue = ''.obs;
  final RxString minPrice = ''.obs;
  final RxString maxPrice = ''.obs;
  final RxInt selectedCategoryId = 0.obs;

  final RxList results = [].obs;

  final List<Map<String, dynamic>> categories = [
    {'id': 1, 'name': 'سيارات'},
    {'id': 2, 'name': 'لابتوبات'},
    {'id': 3, 'name': 'إلكترونيات'},
  ];

  Timer? _debounce;

  void onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), fetchResults);
  }

  void onCategorySelected(int id) {
    selectedCategoryId.value = id;
    fetchResults();
  }

  void fetchResults() async {
    final body = <String, dynamic>{};

    if (useDescription.value && searchValue.value.trim().isNotEmpty) {
      body['description'] = searchValue.value.trim();
    }

    if (useLocation.value && locationValue.value.trim().isNotEmpty) {
      body['location'] = locationValue.value.trim();
    }

    if (usePrice.value) {
      final min = int.tryParse(minPrice.value.trim());
      final max = int.tryParse(maxPrice.value.trim());
      if (min != null) body['min_price'] = min;
      if (max != null) body['max_price'] = max;
    }

    if (useCategory.value && selectedCategoryId.value != 0) {
      body['category_id'] = selectedCategoryId.value;
    }

    if (body.isEmpty) return;

    try {
      final response = await searchAdd.postData(body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        results.value = data['data']['data'];
      } else {
        Get.snackbar('فشل', 'خطأ في الاتصال');
        //print(response.body);
      }
    } catch (e) {
      print('خطأ في الاتصال: $e');
    }
  }

  goToAddInfo(int adId) {
    Get.toNamed(AppRoute.addinfo, arguments: {'adId': adId});
  }
}
