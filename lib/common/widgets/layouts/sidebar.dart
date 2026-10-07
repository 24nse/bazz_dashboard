import 'package:flutter/material.dart';
import '../../../screens/admin/admin_dashboard_screen.dart'; 

class Sidebar extends StatelessWidget {
  final AdminView currentView;
  final Function(AdminView) onSelected;

  const Sidebar({super.key, required this.currentView, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4F46E5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.storefront, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Store Admin',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF131B2E),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          SidebarItem(icon: Icons.dashboard_outlined, title: 'Dashboard', isActive: currentView == AdminView.dashboard, onTap: () => onSelected(AdminView.dashboard)),
          SidebarItem(icon: Icons.inventory_2_outlined, title: 'Products', isActive: currentView == AdminView.products, onTap: () => onSelected(AdminView.products)),
          SidebarItem(icon: Icons.shopping_bag_outlined, title: 'Orders', isActive: currentView == AdminView.orders, onTap: () => onSelected(AdminView.orders)),
          SidebarItem(icon: Icons.people_outline, title: 'Customers', isActive: currentView == AdminView.customers, onTap: () => onSelected(AdminView.customers)),
          SidebarItem(icon: Icons.campaign_outlined, title: 'Promotions', isActive: currentView == AdminView.promotions, onTap: () => onSelected(AdminView.promotions)),
          const Spacer(),
          SidebarItem(icon: Icons.settings_outlined, title: 'Settings', isActive: currentView == AdminView.settings, onTap: () => onSelected(AdminView.settings)),
          const SizedBox(height: 24),
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

  const SidebarItem({
    super.key,
    required this.icon,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF4F46E5) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(
                icon,
                color: isActive ? Colors.white : const Color(0xFF475569),
                size: 22,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive ? Colors.white : const Color(0xFF475569),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
