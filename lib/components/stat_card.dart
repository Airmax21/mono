import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String mainValue;
  final String changeValue;
  final String percentageChange;
  final Color indicatorColor;
  final IconData? icon; // Opsional jika ingin ada ikon di dalam lingkaran

  const StatCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.mainValue,
    required this.changeValue,
    required this.percentageChange,
    required this.indicatorColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;
    return Container(
      width: 170, // Lebar kartu
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Get.theme.primaryColor, 
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.grey.withValues(alpha: 0.2),
              child: Icon(
                icon, 
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Judul
          Text(
            title,
            style: Get.textTheme.titleSmall?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),

          // Subtitle
          Text(
            subtitle,
            style: Get.textTheme.bodySmall?.copyWith(
              fontSize: 12,
              color: isDark ? Colors.white60 : Colors.black54,
            ),
          ),
          const SizedBox(height: 12),
          
          // Nilai utama
          Text(
            mainValue,
            style: Get.textTheme.bodyMedium?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          // Indikator perubahan (pill)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: indicatorColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$changeValue ($percentageChange)',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}