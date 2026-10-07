import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/widgets/layouts/sidebar.dart';
import '../../common/widgets/layouts/appbar.dart';
import '../../common/widgets/dashboard/metric_card.dart';
import '../../common/widgets/dashboard/chart_card.dart';
import '../../common/widgets/dashboard/recent_orders_card.dart';
import 'views/products_view.dart';
import 'views/orders_view.dart';
import 'views/customers_view.dart';
import 'views/settings_view.dart';
import 'views/promotions_view.dart';
import 'views/banners_view.dart';
import 'views/brands_view.dart';
import 'views/user_roles_view.dart';
import 'views/categories_view.dart';
import 'views/notifications_view.dart';
import 'views/reports_view.dart';

enum AdminView { dashboard, products, categories, orders, customers, promotions, banners, brands, notifications, reports, userRoles, settings }

final adminViewProvider = StateProvider<AdminView>((ref) => AdminView.dashboard);

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentView = ref.watch(adminViewProvider);

    void onViewSelected(AdminView view) {
      ref.read(adminViewProvider.notifier).state = view;
    }
    final isDesktop = MediaQuery.of(context).size.width >= 1024;
    final isTablet = MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        drawer: isDesktop ? null : Drawer(child: Sidebar(currentView: currentView, onSelected: onViewSelected)),
      body: Row(
        children: [
          // Sidebar
          if (isDesktop) Sidebar(currentView: currentView, onSelected: onViewSelected),
          
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Top App Bar
                DashboardAppBar(isDesktop: isDesktop, isTablet: isTablet, isMobile: isMobile),
                // Dashboard Content Area
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(isMobile ? 16 : 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Content Dashboard Widgets
                        Expanded(
                          child: _buildCurrentViewContent(currentView, isDesktop, isTablet, isMobile),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getAppBarTitle(AdminView view) {
    switch (view) {
      case AdminView.dashboard: return 'Overview';
      case AdminView.products: return 'Products Management';
      case AdminView.categories: return 'Categories & Classifications';
      case AdminView.orders: return 'Orders & Shipping';
      case AdminView.customers: return 'Customers';
      case AdminView.promotions: return 'Promotions & Coupons';
      case AdminView.banners: return 'Banners & Media';
      case AdminView.brands: return 'Brands Management';
      case AdminView.notifications: return 'Notifications & FCM';
      case AdminView.reports: return 'Reports & Analytics';
      case AdminView.userRoles: return 'User Roles & Permissions';
      case AdminView.settings: return 'Store Settings';
    }
  }

  Widget _buildCurrentViewContent(AdminView view, bool isDesktop, bool isTablet, bool isMobile) {
    if (view == AdminView.products) {
      return const ProductsView();
    }
    if (view == AdminView.categories) {
      return const CategoriesView();
    }
    if (view == AdminView.orders) {
      return const OrdersView();
    }
    if (view == AdminView.customers) {
      return const CustomersView();
    }
    if (view == AdminView.settings) {
      return const SettingsView();
    }
    if (view == AdminView.promotions) {
      return const PromotionsView();
    }
    if (view == AdminView.banners) {
      return const BannersView();
    }
    if (view == AdminView.brands) {
      return const BrandsView();
    }
    if (view == AdminView.userRoles) {
      return const UserRolesView();
    }
    if (view == AdminView.notifications) {
      return const NotificationsView();
    }
    if (view == AdminView.reports) {
      return const ReportsView();
    }
    if (view != AdminView.dashboard) {
      return Center(
        child: Text(
          'Placeholder for ${_getAppBarTitle(view)}',
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            color: Color(0xFF94A3B8),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Metrics grid
          LayoutBuilder(
            builder: (context, constraints) {
              final double cardWidth = isMobile 
                ? constraints.maxWidth 
                : (isTablet ? (constraints.maxWidth - 24) / 2 : (constraints.maxWidth - (24 * 4)) / 5);
              
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  SizedBox(width: cardWidth, child: MetricCard(
                    title: 'إجمالي المبيعات', value: '148,920', unit: 'ر.س', icon: Icons.payments,
                    iconBgColor: const Color(0xFFE2DFFF).withValues(alpha: 0.6), iconColor: const Color(0xFF3525CD),
                    badgeText: '+18.4%', badgeBgColor: const Color(0xFFECFDF5), badgeTextColor: const Color(0xFF059669), badgeIcon: Icons.arrow_upward,
                    subtitle: 'مقارنة بالشهر الماضي',
                  )),
                  SizedBox(width: cardWidth, child: const MetricCard(
                    title: 'إجمالي الطلبات', value: '1,420', unit: 'طلب', icon: Icons.shopping_basket,
                    iconBgColor: Color(0xFFEAEDFF), iconColor: Color(0xFF4D44E3),
                    badgeText: '+12.2%', badgeBgColor: Color(0xFFECFDF5), badgeTextColor: Color(0xFF059669), badgeIcon: Icons.arrow_upward,
                    subtitle: 'خلال هذا الأسبوع',
                  )),
                  SizedBox(width: cardWidth, child: MetricCard(
                    title: 'متوسط قيمة الطلب', value: '385', unit: 'ر.س', icon: Icons.receipt_long,
                    iconBgColor: const Color(0xFFDAE2FD).withValues(alpha: 0.7), iconColor: const Color(0xFF464555),
                    badgeText: '+5.1%', badgeBgColor: const Color(0xFFECFDF5), badgeTextColor: const Color(0xFF059669), badgeIcon: Icons.arrow_upward,
                    subtitle: 'نمو إيجابي مستقر',
                  )),
                  SizedBox(width: cardWidth, child: MetricCard(
                    title: 'العملاء النشطون', value: '892', unit: 'عميل', icon: Icons.person_add,
                    iconBgColor: const Color(0xFFE2E7FF), iconColor: const Color(0xFF3525CD),
                    badgeText: '+24', badgeBgColor: const Color(0xFFE2DFFF).withValues(alpha: 0.4), badgeTextColor: const Color(0xFF3525CD),
                    subtitle: 'عميل جديد اليوم',
                  )),
                  SizedBox(width: cardWidth, child: MetricCard(
                    title: 'تنبيه المخزون المنخفض', value: '6', unit: 'منتجات', icon: Icons.warning,
                    titleColor: const Color(0xFF855300), valueColor: const Color(0xFF855300), borderColor: const Color(0xFFFEA619).withValues(alpha: 0.4),
                    iconBgColor: const Color(0xFFFFDDB8).withValues(alpha: 0.5), iconColor: const Color(0xFF855300),
                    badgeText: 'إجراء مطلوب', badgeBgColor: const Color(0xFFFFDDB8), badgeTextColor: const Color(0xFF684000),
                    subtitle: 'تحتاج لإعادة توريد',
                  )),
                ],
              );
            }
          ),
          const SizedBox(height: 32),
          if (isDesktop) ...[
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: RevenueChartCard()),
                SizedBox(width: 24),
                Expanded(flex: 1, child: CategorySalesCard()),
              ],
            ),
            const SizedBox(height: 24),
            const RecentOrdersCard(),
          ] else ...[
            const RevenueChartCard(),
            const SizedBox(height: 24),
            const CategorySalesCard(),
            const SizedBox(height: 24),
            const RecentOrdersCard(),
          ],
        ],
      ),
    ));
  }
}
