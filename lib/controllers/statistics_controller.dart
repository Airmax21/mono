import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/database/api_client.dart';
import 'package:mono_app/database/models.dart';

class StatisticsController extends GetxController {
  final ApiClient api = Get.find<ApiClient>();

  final statistics = Rxn<TransactionStatistics>();
  final isLoading = false.obs;

  final selectedMonth = ''.obs; // Format: 'YYYY-MM'

  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    selectedMonth.value = '${now.year}-${now.month.toString().padLeft(2, '0')}';
    fetchStatistics();
  }

  Future<void> fetchStatistics() async {
    isLoading.value = true;
    try {
      final stats = await api.getTransactionStatistics(month: selectedMonth.value);
      if (stats != null) {
        statistics.value = stats;
      }
    } catch (e) {
      debugPrint('Error loading statistics: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void changeMonth(String month) {
    selectedMonth.value = month;
    fetchStatistics();
  }
}
