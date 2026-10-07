import 'package:flutter/material.dart';

class DashboardAppBar extends StatelessWidget {
  final bool isDesktop;
  final bool isTablet;
  final bool isMobile;

  const DashboardAppBar({
    super.key,
    required this.isDesktop,
    required this.isTablet,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.03),
            offset: const Offset(0, 2),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (!isDesktop)
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, color: Color(0xFF131B2E)),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
              if (!isDesktop) const SizedBox(width: 12),
              // Search Bar
              if (!isMobile)
                Container(
                  width: isTablet ? 250 : 400,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Color(0xFF94A3B8)),
                      SizedBox(width: 12),
                      Text(
                        'Search anything...',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0xFF94A3B8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          // Actions
          Row(
            children: [
              if (isMobile)
                IconButton(
                  icon: const Icon(Icons.search, color: Color(0xFF475569)),
                  onPressed: () {},
                ),
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Color(0xFF475569)),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              const CircleAvatar(
                backgroundColor: Color(0xFFE2E8F0),
                child: Icon(Icons.person, color: Color(0xFF475569)),
              )
            ],
          )
        ],
      ),
    );
  }
}
