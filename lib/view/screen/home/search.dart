import 'package:buyro_app/controller/home/search_controller.dart';
import 'package:buyro_app/view/widget/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchControllerP controller = Get.put(SearchControllerP());
    return Scaffold(
      appBar: AppBar(title: const Text('البحث')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckboxListTile(
                title: const Text('بحث حسب الوصف'),
                value: controller.useDescription.value,
                onChanged: (val) => controller.useDescription.value = val!,
              ),
              if (controller.useDescription.value)
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'أدخل الوصف',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) => controller.searchValue.value = val,
                ),

              const SizedBox(height: 10),

              CheckboxListTile(
                title: const Text('بحث حسب الموقع'),
                value: controller.useLocation.value,
                onChanged: (val) => controller.useLocation.value = val!,
              ),
              if (controller.useLocation.value)
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'أدخل الموقع',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) => controller.locationValue.value = val,
                ),

              const SizedBox(height: 10),

              CheckboxListTile(
                title: const Text('بحث حسب السعر'),
                value: controller.usePrice.value,
                onChanged: (val) => controller.usePrice.value = val!,
              ),
              if (controller.usePrice.value)
                Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'السعر الأدنى',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => controller.minPrice.value = val,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'السعر الأعلى',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => controller.maxPrice.value = val,
                    ),
                  ],
                ),

              const SizedBox(height: 10),

              CheckboxListTile(
                title: const Text('بحث حسب التصنيف'),
                value: controller.useCategory.value,
                onChanged: (val) => controller.useCategory.value = val!,
              ),
              if (controller.useCategory.value)
                DropdownButton<int>(
                  isExpanded: true,
                  value:
                      controller.selectedCategoryId.value == 0
                          ? null
                          : controller.selectedCategoryId.value,
                  hint: const Text('اختر التصنيف'),
                  items:
                      controller.categories
                          .map(
                            (cat) => DropdownMenuItem<int>(
                              value: cat['id'],
                              child: Text(cat['name']),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.onCategorySelected(value);
                    }
                  },
                ),

              const SizedBox(height: 20),

              Center(
                child: ElevatedButton.icon(
                  onPressed: controller.fetchResults,
                  icon: const Icon(Icons.search),
                  label: const Text('بحث'),
                ),
              ),

              const SizedBox(height: 20),

              if (controller.results.isNotEmpty)
                const Text('النتائج:', style: TextStyle(fontSize: 18)),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.results.length,
                itemBuilder: (context, index) {
                  final ad = controller.results[index];
                  return InkWell(
                    onTap: () {
                      controller.goToAddInfo(ad['id']);
                    },
                    child: ProductCard(product: ad),
                  );
                },
              ),

              if (controller.results.isEmpty)
                const Center(child: Text('لا توجد نتائج حالياً')),
            ],
          ),
        ),
      ),
    );
  }
}
