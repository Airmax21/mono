import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/database/api_client.dart';
import 'package:mono_app/database/models.dart';

class ChatController extends GetxController {
  final ApiClient api = Get.find<ApiClient>();

  final sessions = <ChatSession>[].obs;
  final messages = <ChatMessage>[].obs;
  final selectedSession = Rxn<ChatSession>();

  final textController = TextEditingController();
  final scrollController = ScrollController();

  final isLoadingSessions = false.obs;
  final isLoadingMessages = false.obs;
  final isStreaming = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSessions();
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> fetchSessions() async {
    isLoadingSessions.value = true;
    try {
      final list = await api.getChatSessions();
      sessions.assignAll(list);
      
      // Auto-select first session if none selected and list is not empty
      if (selectedSession.value == null && list.isNotEmpty) {
        selectSession(list.first);
      }
    } catch (e) {
      debugPrint('Error fetching chat sessions: $e');
    } finally {
      isLoadingSessions.value = false;
    }
  }

  Future<void> selectSession(ChatSession session) async {
    selectedSession.value = session;
    messages.clear();
    isLoadingMessages.value = true;
    
    try {
      final history = await api.getChatMessages(session.id);
      messages.assignAll(history);
      scrollToBottom();
    } catch (e) {
      debugPrint('Error loading messages: $e');
    } finally {
      isLoadingMessages.value = false;
    }
  }

  Future<void> createNewSession() async {
    final title = 'Sesi Chat Baru ${sessions.length + 1}';
    try {
      final session = await api.createChatSession(title);
      sessions.insert(0, session);
      selectSession(session);
    } catch (e) {
      Get.snackbar('Error', 'Gagal membuat sesi baru: $e');
    }
  }

  Future<void> deleteSession(String sessionId) async {
    try {
      await api.deleteChatSession(sessionId);
      sessions.removeWhere((s) => s.id == sessionId);
      
      if (selectedSession.value?.id == sessionId) {
        selectedSession.value = null;
        messages.clear();
        if (sessions.isNotEmpty) {
          selectSession(sessions.first);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal menghapus sesi: $e');
    }
  }

  Future<void> sendMessage() async {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    textController.clear();

    // If no session is selected, create one first
    if (selectedSession.value == null) {
      await createNewSession();
    }

    final currentSession = selectedSession.value;
    if (currentSession == null) return;

    // Append User Message to UI locally
    final userMsg = ChatMessage(
      id: 'temp_user_${DateTime.now().millisecondsSinceEpoch}',
      sessionId: currentSession.id,
      role: 'user',
      content: text,
      createdAt: DateTime.now(),
    );
    messages.add(userMsg);
    scrollToBottom();

    // Append a blank assistant message for streaming content
    final botMsgId = 'temp_bot_${DateTime.now().millisecondsSinceEpoch}';
    final botMsg = ChatMessage(
      id: botMsgId,
      sessionId: currentSession.id,
      role: 'assistant',
      content: '',
      createdAt: DateTime.now(),
    );
    messages.add(botMsg);
    scrollToBottom();

    isStreaming.value = true;
    String fullBotContent = '';

    try {
      await api.chatStream(
        sessionId: currentSession.id,
        message: text,
        onChunk: (chunk) {
          fullBotContent += chunk.content;
          
          // Update assistant message in list
          final index = messages.indexWhere((m) => m.id == botMsgId);
          if (index != -1) {
            messages[index] = ChatMessage(
              id: botMsgId,
              sessionId: currentSession.id,
              role: 'assistant',
              content: fullBotContent,
              createdAt: botMsg.createdAt,
            );
          }
          scrollToBottom();
        },
      );

      // Reload messages from server to get database IDs
      final history = await api.getChatMessages(currentSession.id);
      messages.assignAll(history);
      scrollToBottom();
    } catch (e) {
      // In case of error, show it in assistant message
      final index = messages.indexWhere((m) => m.id == botMsgId);
      if (index != -1) {
        messages[index] = ChatMessage(
          id: botMsgId,
          sessionId: currentSession.id,
          role: 'assistant',
          content: 'Gagal mendapatkan respon dari server: $e',
          createdAt: botMsg.createdAt,
        );
      }
    } finally {
      isStreaming.value = false;
    }
  }
}
