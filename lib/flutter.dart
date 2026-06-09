
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),

      appBar: AppBar(
        title: const Text(
          "Second Screen",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withOpacity(0.25),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Step indicator
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.looks_two_rounded,
                        color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Step 2 of 3",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          "Aap doosre step par hain!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),


            const Text(
              "Aage kya hai?",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF3D3A5C),
              ),
            ),

            const SizedBox(height: 14),

            // Feature cards — teen chhoti cards
            ..._features.map((f) => _FeatureRow(
              icon: f['icon'] as IconData,
              title: f['title'] as String,
              desc: f['desc'] as String,
            )),

            const Spacer(),


            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, 'buffer'),
                icon: const Icon(Icons.arrow_forward_rounded),
                label: const Text("Head to Buffer Screen"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),

      // Bottom navigation bar
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
              GButton(
                icon: Icons.local_activity_rounded,
                text: 'Activity',
                onPressed: () => Navigator.pushNamed(context, 'buffer'),
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

// Feature list — easy to add/remove karo
final _features = [
  {
    'icon': Icons.flash_on_rounded,
    'title': 'Fast Navigation',
    'desc': 'Faster Navigation System',
  },
  {
    'icon': Icons.palette_rounded,
    'title': 'Clean UI',
    'desc': 'Simpler Experience',
  },
  {
    'icon': Icons.storage_rounded,
    'title': 'Buffer Ready',
    'desc': 'NEXT STEP READY',
  },
];


class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;

  const _FeatureRow({
    required this.icon,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF6C63FF), size: 22),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF2D2B45),
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9896A8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}