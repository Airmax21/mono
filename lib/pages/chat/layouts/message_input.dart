import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/controllers/chat_controller.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();

    final isDark = Get.isDarkMode;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.1), 
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.white10 : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: isDark 
                    ? null 
                    : Border.all(color: Colors.black.withValues(alpha: 0.1), width: 1),
              ),
              child: TextFormField(
                controller: controller.textController,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87, 
                  fontSize: 15,
                ),
                maxLines: 4,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: 'chat_input_hint'.tr,
                  hintStyle: TextStyle(
                    color: isDark ? Colors.white38 : Colors.black38,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onFieldSubmitted: (value) {
                  if (controller.isStreaming.value == false) {
                    controller.sendMessage();
                  }
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Send Button
          Obx(() {
            final isStreaming = controller.isStreaming.value;
            return Container(
              decoration: const BoxDecoration(
                color: Color(0xFF3757CA),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: isStreaming
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.send, color: Colors.white, size: 20),
                onPressed: isStreaming ? null : controller.sendMessage,
              ),
            );
          }),
        ],
      ),
    );
  }
}
