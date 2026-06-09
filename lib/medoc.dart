// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),

      appBar: AppBar(
        leading: const Icon(Icons.menu_rounded), // hamburger icon
        title: const Text(
          "Home",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome card — greeting section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF9B8FFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Namaste! 👋",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "LetsGO",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 36),

            // Subheading — section label
            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF3D3A5C),
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 16),

            // Main navigation button — second screen pe le jaata hai
            _NavCard(
              icon: Icons.arrow_forward_ios_rounded,
              label: "Go to Second Screen",
              subtitle: "CLick Here For Next Step",
              onTap: () => Navigator.pushNamed(context, 'second'),
            ),
          ],
        ),
      ),

      // Bottom nav bar — consistent across screens
      bottomNavigationBar: _BottomNav(
        context: context,
        activeIndex: 0,
        onSecond: () => Navigator.pushNamed(context, 'second'),
      ),
    );
  }
}


class _NavCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  const _NavCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFEEECFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF6C63FF), size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Color(0xFF2D2B45),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9896A8),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFFB0AEC8)),
          ],
        ),
      ),
    );
  }
}

// Bottom nav bar — teen tabs: Home, Activity, Wallet
class _BottomNav extends StatelessWidget {
  final BuildContext context;
  final int activeIndex;
  final VoidCallback onSecond;

  const _BottomNav({
    required this.context,
    required this.activeIndex,
    required this.onSecond,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              onPressed: onSecond, // home se second pe
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
    );
  }
}