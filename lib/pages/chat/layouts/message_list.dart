import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/controllers/chat_controller.dart';
import 'package:mono_app/size_config.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();

    return Obx(() {
      final list = controller.messages;

      if (controller.isLoadingMessages.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (list.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 64,
                  color: Get.theme.primaryColor.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'chat_intro_title'.tr,
                  style: Get.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'chat_intro_desc'.tr,
                  style: Get.textTheme.bodyMedium?.copyWith(
                    color: Get.isDarkMode ? Colors.white60 : Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }

      return ListView.builder(
        controller: controller.scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final msg = list[index];
          final isUser = msg.role == 'user';

          return Align(
            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              constraints: BoxConstraints(
                maxWidth: getProportionateScreenWidth(280),
              ),
              decoration: BoxDecoration(
                color: isUser 
                  ? const Color(0xFF3757CA) 
                  : Get.theme.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: isUser ? const Radius.circular(16) : const Radius.circular(0),
                  bottomRight: isUser ? const Radius.circular(0) : const Radius.circular(16),
                ),
              ),
              child: Text(
                msg.content,
                style: TextStyle(
                  color: isUser 
                    ? Colors.white 
                    : (Get.isDarkMode ? Colors.white : Colors.black87),
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
