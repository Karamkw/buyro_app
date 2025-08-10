import 'package:buyro_app/controller/home/add_ad_controller.dart';
import 'package:buyro_app/core/functions/validinput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAdPage extends StatelessWidget {
  const AddAdPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddAdController controller = Get.put(AddAdController());
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة إعلان')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formstate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('السعر'),
              TextFormField(
                validator: (val) {
                  return validInput(val!, 1, 200, "can't be Empty");
                },
                controller: controller.priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'أدخل السعر'),
              ),
              const SizedBox(height: 16),

              const Text('الموقع'),
              TextFormField(
                validator: (val) {
                  return validInput(val!, 1, 200, "can't be Empty");
                },
                controller: controller.locationController,
                decoration: const InputDecoration(hintText: 'أدخل الموقع'),
              ),
              const SizedBox(height: 16),

              const Text('رقم التواصل'),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (val) {
                  return validInput(val!, 10, 15, "phone");
                },
                controller: controller.phoneController,
                decoration: const InputDecoration(
                  hintText: 'أدخل رقم الموبايل',
                ),
              ),
              const SizedBox(height: 16),

              const Text('التصنيف'),
              Obx(
                () => DropdownButton<int>(
                  isExpanded: true,
                  value:
                      controller.selectedCategoryId.value == 0
                          ? null
                          : controller.selectedCategoryId.value,
                  hint: const Text('اختر التصنيف'),
                  items:
                      controller.categories.map((Map<String, dynamic> cat) {
                        return DropdownMenuItem<int>(
                          value: cat['id'] as int,
                          child: Text((cat['name'])),
                        );
                      }).toList(),
                  onChanged: (val) {
                    if (val != null) controller.selectedCategoryId.value = val;
                  },
                ),
              ),
              const SizedBox(height: 16),

              const Text('الوصف'),
              TextFormField(
                validator: (val) {
                  return validInput(val!, 1, 200, "can't be Empty");
                },
                controller: controller.descriptionController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'أدخل وصف الإعلان',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              Center(
                child: ElevatedButton(
                  onPressed: controller.submitAd,
                  child: const Text('نشر الإعلان'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
