import 'package:flutter/material.dart';

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
    return Container(
      width: 170, // Lebar kartu
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        // Warna latar belakang kartu untuk dark mode
        color: const Color(0xFF2a2d36), 
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Lingkaran abu-abu di atas
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey.withOpacity(0.2),
            child: icon != null 
                ? Icon(icon, color: Colors.white70) 
                : null,
          ),
          const SizedBox(height: 20),

          // Judul
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),

          // Subtitle
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          
          // Nilai utama
          Text(
            mainValue,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
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