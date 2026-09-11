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
      title: 'هيبة - Heeba Rewards',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0B0B),
        primaryColor: Colors.amber,
      ),
      home: const MainHomeScreen(),
    );
  }
}

// الشاشة الرئيسية للتطبيق
class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int userPoints = 1250; // رصيد النقاط التجريبي

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('هيبة | HEBEA', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        actions: [
          // زر الدخول لوحة التحكم (Admin Panel) المخفي للأدمن
          IconButton(
            icon: const Icon(Icons.admin_panel_settings, color: Colors.amber),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminPanelScreen()));
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // كارت الملف الشخصي والـ ID
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber, width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Karrar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 5),
                    Text('ID: 125482', style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.stars, color: Colors.amber, size: 28),
                    const SizedBox(width: 8),
                    Text('$userPoints', style: const TextStyle(fontSize: 20, color: Colors.amber, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),

          // زر الذهاب لعجلة الحظ المضيئة
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const GlowingWheelScreen()));
              },
              child: const Text('عجلة الحظ اليومية (المضيئة)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 15),

          // قسم كود الهدية (Promo Code)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('أدخل كود الهدية الترويجي', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'مثال: HEEBA2026',
                          filled: true,
                          fillColor: Colors.black45,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم تفعيل الكود بنجاح!')));
                      },
                      child: const Text('تفعيل'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// شاشة عجلة الحظ المضيئة تماماً مثل الصورة
class GlowingWheelScreen extends StatelessWidget {
  const GlowingWheelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('عجلة الحظ'), backgroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // المؤقت التنازلي
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.amber),
                boxShadow: [BoxShadow(color: Colors.amber.withOpacity(0.3), blurRadius: 10)],
              ),
              child: const Text('الوقت المتبقي للتدوير القادم: 23:59:12', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 40),
            // العجلة المضيئة
            Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.amber, width: 4),
                  boxShadow: [
                    BoxShadow(color: Colors.amber.withOpacity(0.6), blurRadius: 30, spreadRadius: 5),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Text('عجلة هيبة الفخمة', style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.amber,
                      ),
                      child: const Center(
                        child: Text('إدور', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// لوحة التحكم الخاصة بك (Admin Panel) داخل التطبيق للتحكم السريع
class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة تحكم الأدمن'), backgroundColor: Colors.black),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('التحكم السريع بالتطبيق والجوائز', style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          SwitchListTile(
            title: const Text('تفعيل عجلة الحظ'),
            value: true,
            onChanged: (val) {},
            activeColor: Colors.amber,
          ),
          ListTile(
            title: const Text('تعديل نسب الجوائز'),
            subtitle: const Text('التحكم بنسب الحظ (عادية، نادرة، أسطورية)'),
            trailing: const Icon(Icons.edit, color: Colors.amber),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم فتح نافذة تعديل النسب!')));
            },
          ),
          ListTile(
            title: const Text('إضافة كود ترويجي جديد'),
            subtitle: const Text('صنع كود هدايا نقاط للأعضاء'),
            trailing: const Icon(Icons.add_circle, color: Colors.amber),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إضافة الكود بنجاح!')));
            },
          ),
        ],
      ),
    );
  }
}
