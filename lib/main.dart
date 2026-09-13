import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HeebaStoreScreen(),
  ));
}// update

class HeebaStoreScreen extends StatelessWidget {
  const HeebaStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text(
          'متجر هيبة - عجلة الجوائز',
          style: TextStyle(color: Color(0xFFFFB300), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFFB300), width: 1),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Color(0xFFFFB300), size: 28),
                  SizedBox(width: 10),
                  Text(
                    'أهلاً بك في نظام إدارة جوائز هيبة',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildPrizeCard('جائزة PUBG أسطورية', 'أسطورية', '2%', 'عنصر'),
                  _buildPrizeCard('500 نقطة ملحمية', 'ملحمية', '8%', 'نقاط'),
                  _buildPrizeCard('100 نقطة نادرة', 'نادرة', '15%', 'نقاط'),
                  _buildPrizeCard('50 نقطة عادية', 'عادية', '25%', 'نقاط'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrizeCard(String title, String rarity, String weight, String type) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('الوزن: $weight • النوع: $type', style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFB300).withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(rarity, style: const TextStyle(color: Color(0xFFFFB300), fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
