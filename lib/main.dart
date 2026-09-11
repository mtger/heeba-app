import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const HeebaApp());
}

class HeebaApp extends StatelessWidget {
  const HeebaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'هيبة - Heeba',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0C),
        primaryColor: const Color(0xFFFFD700),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFFFD700),
          secondary: const Color(0xFFFF4500),
          surface: const Color(0xFF16161E),
        ),
      ),
      home: const HeebaHomeScreen(),
    );
  }
}

class HeebaHomeScreen extends StatefulWidget {
  const HeebaHomeScreen({super.key});

  @override
  State<HeebaHomeScreen> createState() => _HeebaHomeScreenState();
}

class _HeebaHomeScreenState extends State<HeebaHomeScreen> {
  int userPoints = 250;
  final String userId = "HEEBA-9920";
  bool isSpinning = false;
  String lastReward = "لم تقم بالتدوير بعد";

  final TextEditingController _promoController = TextEditingController();
  final List<String> rewards = ['50 نقطة', '100 نقطة', 'حظ أوفر', '200 نقطة', 'هدية ملكية', '10 نقاط'];

  void _spinWheel() {
    if (isSpinning) return;
    setState(() {
      isSpinning = true;
    });

    final random = Random();
    int index = random.nextInt(rewards.length);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isSpinning = false;
        lastReward = rewards[index];
        if (lastReward.contains('نقطة')) {
          int pts = int.parse(lastReward.split(' ')[0]);
          userPoints += pts;
        } else if (lastReward == 'هدية ملكية') {
          userPoints += 500;
        }
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('مبروك! حصلت على: $lastReward', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFFFFD700),
        ),
      );
    });
  }

  void _applyPromoCode() {
    if (_promoController.text.trim() == 'HEEBA2026') {
      setState(() {
        userPoints += 1000;
        _promoController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تفعيل الكود بنجاح! +1000 نقطة'), backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الكود غير صحيح أو منتهي الصلاحية'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('✨ تطبيق هيبة الملكي ✨', style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // بطاقة الملف الشخصي مع تأثير التوهج
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF1E1E2C), Color(0xFF2D2D44)]),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: const Color(0xFFFFD700).withOpacity(0.3), blurRadius: 15, spreadRadius: 2)
                ],
                border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.5), width: 1.5),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Color(0xFFFFD700),
                    child: Icon(Icons.person, size: 40, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  const Text('مستخدم هيبة المميز', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('المعرف: $userId', style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  const Divider(color: Colors.white24, height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.monetization_on, color: Color(0xFFFFD700)),
                      const SizedBox(width: 8),
                      Text('الرصيد: $userPoints نقطة', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFFFD700))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // عجلة الحظ المضيئة
            const Text('عجلة الحظ اليومية المضيئة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white70)),
            const SizedBox(height: 15),
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF16161E),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.orangeAccent, width: 2),
                boxShadow: [BoxShadow(color: Colors.orangeAccent.withOpacity(0.2), blurRadius: 10)],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, size: 50, color: isSpinning ? Colors.redAccent : const Color(0xFFFFD700)),
                  const SizedBox(height: 10),
                  Text(isSpinning ? 'جاري تدوير العجلة...' : 'النتيجة: $lastReward', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD700),
                      foregroundColor: Colors.black,
                    ),
                    onPressed: isSpinning ? null : _spinWheel,
                    child: const Text('تدوير الآن', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // قسم الكودات (Promo Code)
            const Text('خانة الهدايا والبروموكود', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white70)),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _promoController,
                    decoration: InputDecoration(
                      hintText: 'أدخل كود الهدية هنا',
                      filled: true,
                      fillColor: const Color(0xFF1E1E2C),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF4500),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  onPressed: _applyPromoCode,
                  child: const Text('تفعيل'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
