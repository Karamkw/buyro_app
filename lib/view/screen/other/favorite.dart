import 'package:buyro_app/controller/other/myfavorite_controller.dart';
import 'package:buyro_app/view/widget/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyFavoriteControllerImp());

    return Scaffold(
      appBar: AppBar(title: const Text("المفضلة")),
      body: RefreshIndicator(
        onRefresh: ()async{  await controller.fetchMyFavAds();},
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
        
          if (controller.myFav.isEmpty) {
            return const Center(child: Text("لا توجد إعلانات في المفضلة"));
          }
        
          return ListView.builder(
            itemCount: controller.myFav.length,
            itemBuilder: (context, index) {
              final ad = controller.myFav[index];
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
