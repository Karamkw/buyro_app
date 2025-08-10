import 'package:buyro_app/controller/home/home_controller.dart';
import 'package:buyro_app/core/constant/color.dart';
import 'package:buyro_app/view/screen/other/NotificationsPage.dart';
import 'package:buyro_app/view/widget/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeControllerImp controller = Get.put(HomeControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text("الرئيسية"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              controller.goToserch();
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Get.to(() => NotificationsPage());
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColor,
        tooltip: "إضافة إعلان",
        onPressed: () {
          controller.goToAddad();
        },
        child: const Icon(Icons.add, color: Colors.black, size: 33),
      ),

      body: GetBuilder<HomeControllerImp>(
        builder: (controller) {
          return Column(
            children: [
              const SizedBox(height: 25),
              // categ
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 100,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(child: Text("Category")),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child:
                    controller.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : controller.products.isEmpty
                        ? const Center(child: Text('لا يوجد منتجات حالياً'))
                        : ListView.builder(
                          itemCount: controller.products.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                controller.goToAddInfo(
                                  controller.products[index]['id'],
                                );
                              },
                              child: ProductCard(
                                product: controller.products[index],
                              ),
                            );
                          },
                        ),
              ),
            ],
          );
        },
      ),
    );
  }
}
