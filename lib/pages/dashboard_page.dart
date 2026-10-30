import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/category_sales.dart';
import '../components/kpi_cards.dart';
import '../components/quick_actions.dart';
import '../components/recent_orders.dart';
import '../components/revenue_chart.dart';
import '../components/top_products.dart';

class DashboardPage extends StatelessComponent {
  const DashboardPage({super.key});

  @override
  Component build(BuildContext context) {
    return main_(classes: 'flex-1 overflow-y-auto custom-scroll p-space-xl space-y-space-xl', [
      // 1. KPI Metric Cards Row
      const KpiCards(),

      // 2. Charts & Visual Analytics (Bento Style Layout)
      section(classes: 'grid grid-cols-1 lg:grid-cols-3 gap-space-xl', [
        const RevenueChart(),
        const CategorySales(),
      ]),

      // 3. Recent Orders Table & Top Products / Shortcuts
      section(classes: 'grid grid-cols-1 lg:grid-cols-3 gap-space-xl items-start', [
        const RecentOrders(),
        div(classes: 'space-y-space-xl', [
          const TopProducts(),
          const QuickActions(),
        ]),
      ]),
    ]);
  }
}
