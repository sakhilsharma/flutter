// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class MyBuffer extends StatelessWidget {
  const MyBuffer({super.key});

  // Yeh list hai saari items ki — agar badalni ho toh sirf yahan se badlo
  static const List<_BufferItem> _items = [
    _BufferItem(
      icon: Icons.bolt_rounded,
      title: "Quick Start",
      subtitle: "Jaldi shuru karne ke liye",
      color: Color(0xFF6C63FF),
    ),
    _BufferItem(
      icon: Icons.bar_chart_rounded,
      title: "Analytics",
      subtitle: "Apna progress dekho",
      color: Color(0xFF43C6AC),
    ),
    _BufferItem(
      icon: Icons.notifications_rounded,
      title: "Notifications",
      subtitle: "Koi bhi update mat chuko",
      color: Color(0xFFFF6584),
    ),
    _BufferItem(
      icon: Icons.lock_rounded,
      title: "Security",
      subtitle: "Apna account safe rakho",
      color: Color(0xFFFFB347),
    ),
    _BufferItem(
      icon: Icons.cloud_upload_rounded,
      title: "Backup",
      subtitle: "Data save karo cloud mein",
      color: Color(0xFF43B9FF),
    ),
    _BufferItem(
      icon: Icons.settings_rounded,
      title: "Settings",
      subtitle: "App customize karo apne hisaab se",
      color: Color(0xFF9B59B6),
    ),
    _BufferItem(
      icon: Icons.help_outline_rounded,
      title: "Help & Support",
      subtitle: "Koi problem? Yahan aao",
      color: Color(0xFF2ECC71),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),

      appBar: AppBar(
        title: const Text(
          "Buffer",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Every Thing is Here 📦",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D2B45),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${_items.length} items available",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9896A8),
                  ),
                ),
              ],
            ),
          ),


          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return _BufferCard(
                  item: item,
                  // Home pe wapas le jaata hai — pehle yahan bas 'home' tha
                  onTap: () => Navigator.pushNamed(context, 'home'),
                );
              },
            ),
          ),
        ],
      ),


      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: GNav(
            rippleColor: const Color(0xFFEEECFF),
            hoverColor: const Color(0xFFEEECFF),
            gap: 8,
            activeColor: const Color(0xFF6C63FF),
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 300),
            tabBackgroundColor: const Color(0xFFEEECFF),
            color: Colors.grey,
            tabs: [
              GButton(
                icon: Icons.home_rounded,
                text: 'Home',
                onPressed: () => Navigator.pushNamed(context, 'home'),
              ),
              const GButton(
                icon: Icons.local_activity_rounded,
                text: 'Activity',
              ),
              const GButton(
                icon: Icons.account_balance_wallet_rounded,
                text: 'Wallet',
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _BufferItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _BufferItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });
}


class _BufferCard extends StatelessWidget {
  final _BufferItem item;
  final VoidCallback onTap;

  const _BufferCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Colored icon container
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(item.icon, color: item.color, size: 24),
              ),

              const SizedBox(width: 16),

              // Text section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Color(0xFF2D2B45),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9896A8),
                      ),
                    ),
                  ],
                ),
              ),


              const Icon(Icons.chevron_right_rounded,
                  color: Color(0xFFB0AEC8), size: 20),
            ],
          ),
        ),
      ),
    );
  }
}