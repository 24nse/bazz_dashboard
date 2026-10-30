import 'package:flutter/material.dart';
import '../../../screens/admin/admin_dashboard_screen.dart';

class Sidebar extends StatelessWidget {
  final AdminView currentView;
  final Function(AdminView) onSelected;

  const Sidebar({super.key, required this.currentView, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 288, // 72 x 4 (w-72)
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          left: BorderSide(color: Color(0xFFE2E7FF), width: 1), // rtl left border
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Logo & Brand Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFEAEDFF), width: 1)),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3525CD),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF3525CD).withValues(alpha: 0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: const Icon(Icons.shopping_bag, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'متجر نبض',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF131B2E),
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3525CD).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: const Text(
                            'PRO',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3525CD),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'لوحة الإدارة الرئيسية',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11,
                        color: Color(0xFF464555),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Navigation Links
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 4),
                  child: Text(
                    'نظرة عامة وإدارة المتجر',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF777587),
                    ),
                  ),
                ),
                SidebarItem(
                  icon: Icons.dashboard,
                  title: 'الرئيسية والإحصائيات',
                  isActive: currentView == AdminView.dashboard,
                  onTap: () => onSelected(AdminView.dashboard),
                ),
                SidebarItem(
                  icon: Icons.inventory_2,
                  title: 'المنتجات والمخزون',
                  isActive: currentView == AdminView.products,
                  onTap: () => onSelected(AdminView.products),
                  badge: '340',
                ),
                SidebarItem(
                  icon: Icons.local_shipping,
                  title: 'الطلبات والشحنات',
                  isActive: currentView == AdminView.orders,
                  onTap: () => onSelected(AdminView.orders),
                  badge: '12 جديد',
                  badgeColor: const Color(0xFFFEA619),
                  badgeTextColor: const Color(0xFF684000),
                ),
                SidebarItem(
                  icon: Icons.category,
                  title: 'الأقسام والتصنيفات',
                  isActive: currentView == AdminView.categories,
                  onTap: () => onSelected(AdminView.categories),
                ),
                SidebarItem(
                  icon: Icons.group,
                  title: 'العملاء والمستخدمين',
                  isActive: currentView == AdminView.customers,
                  onTap: () => onSelected(AdminView.customers),
                ),
                
                const Padding(
                  padding: EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 20),
                  child: Text(
                    'التسويق والتقارير',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF777587),
                    ),
                  ),
                ),
                SidebarItem(
                  icon: Icons.confirmation_number,
                  title: 'الكوبونات والعروض',
                  isActive: currentView == AdminView.promotions,
                  onTap: () => onSelected(AdminView.promotions),
                ),
                SidebarItem(
                  icon: Icons.trending_up,
                  title: 'التقارير والمبيعات',
                  isActive: currentView == AdminView.reports,
                  onTap: () => onSelected(AdminView.reports),
                ),
                SidebarItem(
                  icon: Icons.settings,
                  title: 'إعدادات المتجر وFirebase',
                  isActive: currentView == AdminView.settings,
                  onTap: () => onSelected(AdminView.settings),
                ),
                // Extra views to preserve functionality
                SidebarItem(
                  icon: Icons.panorama,
                  title: 'Banners',
                  isActive: currentView == AdminView.banners,
                  onTap: () => onSelected(AdminView.banners),
                ),
                SidebarItem(
                  icon: Icons.branding_watermark,
                  title: 'Brands',
                  isActive: currentView == AdminView.brands,
                  onTap: () => onSelected(AdminView.brands),
                ),
                SidebarItem(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  isActive: currentView == AdminView.notifications,
                  onTap: () => onSelected(AdminView.notifications),
                ),
                SidebarItem(
                  icon: Icons.admin_panel_settings,
                  title: 'User Roles',
                  isActive: currentView == AdminView.userRoles,
                  onTap: () => onSelected(AdminView.userRoles),
                ),
              ],
            ),
          ),
          
          // System Status
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFEAEDFF), width: 1)),
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F3FF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFEAEDFF)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Firebase Sync',
                            style: TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF131B2E)),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECFDF5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'متصل 100%',
                          style: TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF059669)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'تمت المزامنة اللحظية مع تطبيق Flutter بنجاح.',
                    style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: Color(0xFF777587)),
                  ),
                ],
              ),
            ),
          ),
          
          // Admin Profile
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              border: Border(top: BorderSide(color: Color(0xFFEAEDFF), width: 1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2DFFF),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF3525CD).withValues(alpha: 0.2), width: 2),
                      ),
                      child: const Center(child: Icon(Icons.person, color: Color(0xFF3525CD))),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'م. عبد الله السعيد',
                          style: TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF131B2E)),
                        ),
                        Text(
                          'مدير المتجر التنفيذي',
                          style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587)),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.logout, color: Color(0xFF777587), size: 20),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final String? badge;
  final Color? badgeColor;
  final Color? badgeTextColor;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.title,
    required this.isActive,
    required this.onTap,
    this.badge,
    this.badgeColor,
    this.badgeTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF3525CD) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isActive ? [
              BoxShadow(
                color: const Color(0xFF3525CD).withValues(alpha: 0.2),
                blurRadius: 6,
                offset: const Offset(0, 4),
              )
            ] : null,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: isActive ? Colors.white : const Color(0xFF777587),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      color: isActive ? Colors.white : const Color(0xFF464555),
                    ),
                  ),
                ],
              ),
              if (isActive && badge == null)
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              if (badge != null && !isActive)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: badgeColor ?? const Color(0xFFE2E7FF),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    badge!,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      fontWeight: badgeTextColor != null ? FontWeight.bold : FontWeight.normal,
                      color: badgeTextColor ?? const Color(0xFF464555),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
