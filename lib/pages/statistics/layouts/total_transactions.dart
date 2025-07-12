import 'package:flutter/material.dart';
import 'package:mono_app/components/stat_card.dart';
// Jangan lupa import file tempat Anda menyimpan StatCard

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16, // Jarak horizontal antar kartu
      runSpacing: 16, // Jarak vertikal jika ada baris baru
      alignment: WrapAlignment.spaceBetween,
      children: [
        // Kartu Total Revenue
        StatCard(
          title: 'Total Revenue',
          subtitle: 'Rp',
          mainValue: '17,345.24',
          changeValue: 'Rp.6334.32',
          percentageChange: '+0.56%',
          indicatorColor: Colors.green.shade600, // Warna hijau
        ),

        // Kartu Total Expenditure
        StatCard(
          title: 'Total Expenditure',
          subtitle: 'Rp',
          mainValue: '17,345.24',
          changeValue: 'Rp.2334.32',
          percentageChange: '+0.2%',
          indicatorColor: Colors.red.shade600, // Warna merah
        ),
      ],
    );
  }
}

// Untuk menjalankan contoh ini:
void main() {
  runApp(const MaterialApp(
    home: DashboardScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
