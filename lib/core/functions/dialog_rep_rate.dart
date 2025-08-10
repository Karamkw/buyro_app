import 'package:buyro_app/controller/home/add_info_controller.dart';
import 'package:buyro_app/controller/other/reportcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

void showReportDialog(BuildContext context, String adId) {
  final reasons = [
    'spam',
    'fraud',
    'inappropriate_content',
    'wrong_category',
    'already_sold',
    'misleading_information',
    'duplicate',
    'other',
  ];

  final reportController = Get.put(ReportController());
  final textController = TextEditingController();
  final addInfoController = Get.find<AddInfoController>();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("إبلاغ"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() {
                return Column(
                  children:
                      reasons.map((reason) {
                        return RadioListTile<String>(
                          title: Text(reason),
                          value: reason,
                          groupValue: reportController.selectedReason.value,
                          onChanged: (value) {
                            reportController.selectReason(value);
                          },
                        );
                      }).toList(),
                );
              }),
              Obx(() {
                if (reportController.selectedReason.value == 'other') {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: textController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: "سبب آخر...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Get.delete<ReportController>();
            },
            child: const Text("إلغاء"),
          ),
          ElevatedButton(
            onPressed: () {
              final selected = reportController.selectedReason.value;
              if (selected == null) {
                Get.snackbar('تنبيه', 'الرجاء اختيار سبب للإبلاغ');
                return;
              }
              if (selected == 'other' && textController.text.trim().isEmpty) {
                Get.snackbar('تنبيه', 'الرجاء إدخال السبب');
                return;
              }

              addInfoController.reportAd(
                adId: adId,
                reason: selected,
                content:
                    selected == 'other' ? textController.text.trim() : null,
              );

              Navigator.pop(context);
              Get.delete<ReportController>();
            },
            child: const Text("إرسال"),
          ),
        ],
      );
    },
  );
}

void showRatingDialog(BuildContext context, String adId) {
  final addInfoController = Get.find<AddInfoController>();
  final ratingValue = 0.0.obs;
  final textController = TextEditingController();

  Get.defaultDialog(
    title: "تقييم",
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            return RatingBar.builder(
              initialRating: ratingValue.value,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder:
                  (context, _) => const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                ratingValue.value = rating;
              },
            );
          }),

          const SizedBox(height: 20),
          TextField(
            controller: textController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: "اكتب ملاحظتك (اختياري)",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    ),
    textConfirm: "إرسال",
    textCancel: "إلغاء",
    onConfirm: () {
      if (ratingValue.value == 0) {
        Get.snackbar("تنبيه", "الرجاء اختيار التقييم");
        return;
      }

      addInfoController.ratingAd(
        adId: adId,
        rating: ratingValue.value.toString(),
        comment:
            textController.text.trim().isEmpty
                ? null
                : textController.text.trim(),
      );

      Get.back();
    },
  );
}
