import 'package:flutter/material.dart';
import 'package:mono_app/pages/chat/layouts/message_list.dart';
import 'package:mono_app/pages/chat/layouts/message_input.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: MessageList(),
        ),
        MessageInput(),
      ],
    );
  }
}
