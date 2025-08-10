import 'package:buyro_app/controller/other/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الإشعارات"),
        centerTitle: true,
      ),
      body: GetBuilder<NotificationsController>(
        init: NotificationsController(),
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.notifications.isEmpty) {
            return const Center(child: Text("لا توجد إشعارات حالياً."));
          }

          return ListView.builder(
            itemCount: controller.notifications.length,
            itemBuilder: (context, index) {
              final notification = controller.notifications[index];

              return ListTile(
                leading: const Icon(Icons.notifications),
                title: Text(notification['title'] ?? "عنوان غير متوفر"),
                subtitle: Text(notification['body'] ?? "لا يوجد تفاصيل"),
                trailing: Text(notification['date'] ?? ""),
                onTap: () {
              
                },
              );
            },
          );
        },
      ),
    );
  }
}
