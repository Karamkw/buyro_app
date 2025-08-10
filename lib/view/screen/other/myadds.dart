import 'package:buyro_app/controller/other/my_adds_controller.dart';
import 'package:buyro_app/view/widget/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAddsPage extends StatelessWidget {
  const MyAddsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyAddsControllerImp());

    return Scaffold(
      appBar: AppBar(title: const Text("إعلاناتي")),
      body: RefreshIndicator(
        onRefresh: ()async{
           await controller.fetchMyAds();
        },
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
        
          if (controller.myAds.isEmpty) {
            return const Center(child: Text("لا توجد إعلانات لك بعد"));
          }
        
          return ListView.builder(
            itemCount: controller.myAds.length,
            itemBuilder: (context, index) {
              final ad = controller.myAds[index];
              return InkWell(
                onTap: () {
                  controller.goToAddInfo(ad['id']);
                },
                child: ProductCard(product: ad),
              );
            },
          );
        }),
      ),
    );
  }
}
