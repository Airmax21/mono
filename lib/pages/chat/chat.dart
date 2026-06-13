import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/controllers/chat_controller.dart';
import 'package:mono_app/pages/chat/layouts/body.dart';
import 'package:mono_app/pages/chat/layouts/session_drawer.dart';
import 'package:mono_app/size_config.dart';

class ChatPage extends StatelessWidget {
  static String routeName = '/chat';

  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final controller = Get.find<ChatController>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.offNamed('/dashboard'),
        ),
        title: Obx(() {
          final title = controller.selectedSession.value?.title ?? 'chat_title'.tr;
          return Text(title);
        }),
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.history),
              tooltip: 'chat_history_tooltip'.tr,
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_comment),
            tooltip: 'chat_new_session_tooltip'.tr,
            onPressed: () => controller.createNewSession(),
          ),
        ],
      ),
      drawer: const SessionDrawer(),
      body: const Body(),
    );
  }
}
