import 'package:flutter/material.dart';
import 'form_page.dart';
import 'todo_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background dekoratif
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFEDD5DA).withValues(alpha: 0.5),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -40,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF7E4E8).withValues(alpha: 0.6),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 48),

                  // Header
                  Text(
                    'Selamat Datang',
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 3,
                      color: const Color(0xFFB76E79).withValues(alpha: 0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'To-Do\nPraktikum 4',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A2530),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 48,
                    height: 3,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB76E79),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Kelola tugas Anda dengan mudah\ndan terorganisir.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.6,
                    ),
                  ),

                  const Spacer(),

                  // Ilustrasi / dekorasi tengah
                  Center(
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFEDD5DA), Color(0xFFF9EEF1)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFB76E79).withValues(alpha: 0.15),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        size: 56,
                        color: Color(0xFFB76E79),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Tombol
                  _MenuCard(
                    icon: Icons.edit_note_rounded,
                    title: 'Form Todo',
                    subtitle: 'Tambah tugas baru',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => FormPage()),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _MenuCard(
                    icon: Icons.checklist_rounded,
                    title: 'Daftar Todo',
                    subtitle: 'Lihat semua tugas dari API',
                    isOutlined: true,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TodoPage()),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isOutlined;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        decoration: BoxDecoration(
          color: isOutlined ? Colors.transparent : const Color(0xFFB76E79),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFB76E79),
            width: 1.5,
          ),
          boxShadow: isOutlined
              ? null
              : [
                  BoxShadow(
                    color: const Color(0xFFB76E79).withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isOutlined
                    ? const Color(0xFFB76E79).withValues(alpha: 0.1)
                    : Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isOutlined ? const Color(0xFFB76E79) : Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isOutlined ? const Color(0xFF4A2530) : Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: isOutlined
                        ? Colors.grey[500]
                        : Colors.white.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: isOutlined
                  ? const Color(0xFFB76E79)
                  : Colors.white.withValues(alpha: 0.7),
            ),
          ],
        ),
      ),
    );
  }
}