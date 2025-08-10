import 'package:buyro_app/core/functions/dialog_rep_rate.dart';
import 'package:buyro_app/view/widget/app/add_info.dart';
import 'package:buyro_app/view/widget/iconbuttonforlike.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buyro_app/controller/home/add_info_controller.dart';

class AddInfoPage extends StatelessWidget {
  const AddInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddInfoController());
    final String adId = Get.arguments['adId'].toString();

    controller.fetchAdDetails(adId);

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          Get.delete<AddInfoController>();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("تفاصيل الإعلان"),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'report') {
                  showReportDialog(context, adId);
                } else if (value == 'rate') {
                  showRatingDialog(context, adId);
                }
              },
              itemBuilder:
                  (context) => [
                    const PopupMenuItem(value: 'report', child: Text("إبلاغ")),
                    const PopupMenuItem(value: 'rate', child: Text("تقييم")),
                  ],
            ),
          ],
        ),
        body: GetBuilder<AddInfoController>(
          builder: (controller) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.adDetails == null) {
              return const Center(child: Text("لا توجد بيانات للإعلان"));
            }

            final ad = controller.adDetails!;
            final isOwner =
                ad['user_id'].toString() == controller.currentUserId.toString();

            return ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 250,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),

                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Row(
                        children: [
                          Obx(
                            () => iconButtonWithShadow(
                              icon: Icons.star,
                              activeColor: Colors.yellow,
                              isActive: controller.isFavorited.value,
                              onPressed: () {
                                if (controller.isFavorited.value) {
                                  controller.removeFavorite(adId);
                                } else {
                                  controller.toggleFavorite(adId);
                                }
                              },
                            ),
                          ),

                          const SizedBox(width: 8),

                          Obx(
                            () => iconButtonWithShadow(
                              icon: Icons.favorite,
                              activeColor: Colors.red,
                              isActive: controller.isLiked.value,
                              onPressed: () {
                                if (controller.isLiked.value) {
                                  controller.removeLike(adId);
                                } else {
                                  controller.toggleLike(adId);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${ad['price']} ل.س",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InfoTile(
                        icon: Icons.location_on,
                        text: ad['location'] ?? '---',
                      ),
                      InfoTile(
                        icon: Icons.remove_red_eye,
                        text: "عدد المشاهدات: ${ad['views_count']}",
                      ),
                      InfoTile(
                        icon: Icons.category,
                        text: "القسم: ${ad['category']?['name'] ?? '---'}",
                      ),
                      SizedBox(width: 20),
                      InfoTile(
                        icon: Icons.person,
                        text: "البائع: ${ad['user']?['name'] ?? '---'}",
                      ),
                      SizedBox(width: 20),
                      InfoTile(
                        icon: Icons.phone,
                        text: "رقم التواصل : ${ad['phone'] ?? '---'}",
                      ),
                      const Divider(height: 30),
                      Text(
                        ad['description'] ?? '',
                        style: const TextStyle(fontSize: 18),
                      ),
                      if (isOwner) ...[
                        const Divider(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.edit),
                                label: const Text(
                                  "تعديل",
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                  //  backgroundColor: Colors.greenAccent,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  controller.deleteAd(ad['id'].toString());
                                },
                                icon: const Icon(Icons.delete),
                                label: const Text(
                                  "حذف",
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                  // backgroundColor: Colors.orangeAccent,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
