import 'package:flutter/material.dart';

void main() {
  runApp(const HeebaApp());
}

class HeebaApp extends StatelessWidget {
  const HeebaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'متجر هيبة',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFFFFB300),
      ),
      home: const PrizesScreen(),
    );
  }
}

class PrizeItem {
  final String title;
  final String type;
  final String rarity;
  final int points;
  final int weight;
  final int quantity;
  bool isActive;

  PrizeItem({
    required this.title,
    required this.type,
    required this.rarity,
    required this.points,
    required this.weight,
    required this.quantity,
    this.isActive = true,
  });
}

class PrizesScreen extends StatefulWidget {
  const PrizesScreen({super.key});

  @override
  State<PrizesScreen> createState() => _PrizesScreenState();
}

class _PrizesScreenState extends State<PrizesScreen> {
  final List<PrizeItem> prizes = [
    PrizeItem(title: '10 نقاط', type: 'نقاط', rarity: 'عادية', points: 10, weight: 30, quantity: -1),
    PrizeItem(title: '50 نقطة', type: 'نقاط', rarity: 'عادية', points: 50, weight: 25, quantity: -1),
    PrizeItem(title: '100 نقطة', type: 'نقاط', rarity: 'نادرة', points: 100, weight: 15, quantity: -1),
    PrizeItem(title: '500 نقطة', type: 'نقاط', rarity: 'ملحمية', points: 500, weight: 8, quantity: -1),
    PrizeItem(title: 'جائزة PUBG', type: 'عنصر', rarity: 'أسطورية', points: 0, weight: 2, quantity: 1),
    PrizeItem(title: 'جائزة نادرة', type: 'عنصر', rarity: 'ملحمية', points: 0, weight: 5, quantity: -1),
    PrizeItem(title: 'حظ أوفر', type: 'نقاط', rarity: 'عادية', points: 0, weight: 15, quantity: -1),
  ];

  Color _getRarityColor(String rarity) {
    switch (rarity) {
      case 'أسطورية': return const Color(0xFFFFB300);
      case 'ملحمية': return const Color(0xFFAB47BC);
      case 'نادرة': return const Color(0xFF26A69A);
      default: return const Color(0xFF9E9E9E);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('جوائز العجلة', style: TextStyle(color: Color(0xFFFFB300), fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFFB300).withOpacity(0.3)),
            ),
            child: const Text(
              '💡 هذه هي الجوائز التي تظهر داخل عجلة الحظ. اضغط على ✏️ للتعديل، 🗑️ للحذف.',
              style: TextStyle(color: Colors.white70, fontSize: 13),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(height: 12),
          ...prizes.map((prize) => Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _getRarityColor(prize.rarity), width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(prize.title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('وزن ${prize.weight}  •  ${prize.points > 0 ? "${prize.points}pt" : prize.type}',
                        style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getRarityColor(prize.rarity).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: _getRarityColor(prize.rarity)),
                      ),
                      child: Text(prize.rarity, style: TextStyle(color: _getRarityColor(prize.rarity), fontSize: 11)),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent, size: 20),
                      onPressed: () {
                        setState(() {
                          prizes.remove(prize);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }
}
