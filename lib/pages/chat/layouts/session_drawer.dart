import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/controllers/chat_controller.dart';

class SessionDrawer extends StatelessWidget {
  const SessionDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();

    return Drawer(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'chat_drawer_title'.tr,
                style: Get.textTheme.titleMedium,
              ),
            ),
            
            // New Session Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  controller.createNewSession();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: Text(
                  'new_session'.tr,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3757CA),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            const Divider(height: 1),

            // Sessions List
            Expanded(
              child: Obx(() {
                final list = controller.sessions;
                if (controller.isLoadingSessions.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (list.isEmpty) {
                  return Center(
                    child: Text(
                      'no_chat_history'.tr,
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: Get.isDarkMode ? Colors.white54 : Colors.black54,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final session = list[index];
                    final isSelected = controller.selectedSession.value?.id == session.id;

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? (Get.isDarkMode ? Colors.white12 : Get.theme.primaryColor)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.chat_bubble_outline, 
                          color: Get.isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                        title: Text(
                          session.title,
                          style: Get.textTheme.bodyMedium?.copyWith(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          controller.selectSession(session);
                          Navigator.pop(context);
                        },
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                          onPressed: () {
                            // Show delete confirmation dialog
                            Get.dialog(
                              AlertDialog(
                                backgroundColor: Get.theme.colorScheme.surface,
                                title: Text('delete_session_title'.tr),
                                content: Text('delete_session_message'.tr),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: Text('cancel'.tr),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                                    onPressed: () {
                                      controller.deleteSession(session.id);
                                      Get.back();
                                    },
                                    child: Text('delete_btn'.tr, style: const TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
