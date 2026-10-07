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

enum AdminView { dashboard, products, orders, customers, promotions, banners, brands, userRoles, settings }

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

    return Scaffold(
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
                        Text(
                          _getAppBarTitle(currentView),
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF131B2E),
                          ),
                        ),
                        SizedBox(height: isMobile ? 16 : 24),
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
      case AdminView.orders: return 'Orders & Shipping';
      case AdminView.customers: return 'Customers';
      case AdminView.promotions: return 'Promotions & Coupons';
      case AdminView.banners: return 'Banners & Media';
      case AdminView.brands: return 'Brands Management';
      case AdminView.userRoles: return 'User Roles & Permissions';
      case AdminView.settings: return 'Store Settings';
    }
  }

  Widget _buildCurrentViewContent(AdminView view, bool isDesktop, bool isTablet, bool isMobile) {
    if (view == AdminView.products) {
      return const ProductsView();
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
                : (isTablet ? (constraints.maxWidth - 24) / 2 : (constraints.maxWidth - 72) / 4);
              
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  SizedBox(width: cardWidth, child: const MetricCard(title: 'Total Revenue', value: '\$124,563.00', change: '14.5%', isPositive: true, icon: Icons.attach_money)),
                  SizedBox(width: cardWidth, child: const MetricCard(title: 'Total Orders', value: '1,245', change: '8.2%', isPositive: true, icon: Icons.shopping_bag_outlined)),
                  SizedBox(width: cardWidth, child: const MetricCard(title: 'Active Customers', value: '892', change: '2.4%', isPositive: false, icon: Icons.people_outline)),
                  SizedBox(width: cardWidth, child: const MetricCard(title: 'Conversion Rate', value: '3.6%', change: '1.2%', isPositive: true, icon: Icons.trending_up)),
                ],
              );
            }
          ),
          const SizedBox(height: 32),
          if (isDesktop)
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: ChartCard(), 
                ),
                SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: RecentOrdersCard(), 
                ),
              ],
            )
          else
            const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ChartCard(),
                SizedBox(height: 24),
                RecentOrdersCard(),
              ],
            ),
        ],
      ),
    );
  }
}
