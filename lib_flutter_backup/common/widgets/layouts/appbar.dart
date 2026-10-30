import 'package:flutter/material.dart';

class DashboardAppBar extends StatelessWidget {
  final bool isDesktop;
  final bool isTablet;
  final bool isMobile;
  final String title;

  const DashboardAppBar({
    super.key,
    required this.isDesktop,
    required this.isTablet,
    required this.isMobile,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
        start: isMobile ? 16 : 24, 
        end: isMobile ? 16 : 24, 
        top: 14, 
        bottom: 14
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.03),
            offset: const Offset(0, 2),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                if (!isDesktop) ...[
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu, color: Color(0xFF131B2E)),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'مرحباً عبد الله 👋',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF131B2E),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'الأربعاء، 15 مايو 2025 • نظرة تفاعلية للمبيعات',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Color(0xFF777587),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                // Search Bar
                if (isDesktop)
                  Flexible(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 320),
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F3FF),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Color(0xFF777587), size: 20),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'ابحث برقم الطلب، اسم المنتج، العميل...',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Color(0xFF777587),
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: const Color(0xFFEAEDFF)),
                            ),
                            child: const Text(
                              '⌘K',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 11,
                                color: Color(0xFF777587),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Actions
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isDesktop) ...[
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F3FF),
                    borderRadius: BorderRadius.circular(9999),
                    border: Border.all(color: const Color(0xFFEAEDFF)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3525CD),
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: const Text(
                          'اليوم',
                          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('آخر 7 أيام', style: TextStyle(color: Color(0xFF777587), fontSize: 11, fontFamily: 'Inter')),
                      const SizedBox(width: 12),
                      const Text('آخر 30 يوماً', style: TextStyle(color: Color(0xFF777587), fontSize: 11, fontFamily: 'Inter')),
                      const SizedBox(width: 12),
                      const Text('هذا العام', style: TextStyle(color: Color(0xFF777587), fontSize: 11, fontFamily: 'Inter')),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(width: 1, height: 24, color: const Color(0xFFE2E7FF)),
                const SizedBox(width: 12),
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF2F3FF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.storefront, color: Color(0xFF464555), size: 20),
                ),
                const SizedBox(width: 12),
              ],
              
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF2F3FF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.notifications_outlined, color: Color(0xFF464555), size: 22),
                  ),
                  Positioned.directional(
                    textDirection: Directionality.of(context),
                    top: 4,
                    start: 4,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFFBA1A1A),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Center(
                        child: Text(
                          '4',
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 20),
                label: const Text('إضافة منتج جديد'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3525CD),
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shadowColor: const Color(0xFF3525CD).withValues(alpha: 0.2),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  textStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
