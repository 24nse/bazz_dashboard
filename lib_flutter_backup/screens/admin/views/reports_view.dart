import 'package:flutter/material.dart';
import '../../../common/widgets/dashboard/metric_card.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Metrics
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = isMobile
                  ? constraints.maxWidth
                  : (isDesktop ? (constraints.maxWidth - 72) / 4 : (constraints.maxWidth - 24) / 2);
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  SizedBox(width: cardWidth, child: MetricCard(
                    title: 'Gross Sales', value: '248,900', unit: '\$', icon: Icons.monetization_on_outlined,
                    iconBgColor: const Color(0xFFE2DFFF).withValues(alpha: 0.6), iconColor: const Color(0xFF3525CD),
                    badgeText: '+12.3%', badgeBgColor: const Color(0xFFECFDF5), badgeTextColor: const Color(0xFF059669), badgeIcon: Icons.arrow_upward,
                    subtitle: 'Since last month',
                  )),
                  SizedBox(width: cardWidth, child: MetricCard(
                    title: 'Net Profit', value: '87,420', unit: '\$', icon: Icons.account_balance_outlined,
                    iconBgColor: const Color(0xFFEAEDFF), iconColor: const Color(0xFF4D44E3),
                    badgeText: '+8.7%', badgeBgColor: const Color(0xFFECFDF5), badgeTextColor: const Color(0xFF059669), badgeIcon: Icons.arrow_upward,
                    subtitle: 'Since last month',
                  )),
                  SizedBox(width: cardWidth, child: MetricCard(
                    title: 'Avg. Order Value', value: '62.50', unit: '\$', icon: Icons.receipt_long_outlined,
                    iconBgColor: const Color(0xFFDAE2FD).withValues(alpha: 0.7), iconColor: const Color(0xFF464555),
                    badgeText: '-3.1%', badgeBgColor: const Color(0xFFFEE2E2), badgeTextColor: const Color(0xFFEF4444), badgeIcon: Icons.arrow_downward,
                    subtitle: 'Since last month',
                  )),
                  SizedBox(width: cardWidth, child: MetricCard(
                    title: 'Refund Rate', value: '2.1%', unit: '', icon: Icons.undo_outlined,
                    iconBgColor: const Color(0xFFE2E7FF), iconColor: const Color(0xFF3525CD),
                    badgeText: '-0.4%', badgeBgColor: const Color(0xFFECFDF5), badgeTextColor: const Color(0xFF059669), badgeIcon: Icons.arrow_downward,
                    subtitle: 'Since last month',
                  )),
                ],
              );
            },
          ),
          const SizedBox(height: 32),
          // Charts Row
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _ReportChartCard(title: 'Sales Trend', icon: Icons.show_chart)),
                const SizedBox(width: 24),
                Expanded(flex: 1, child: _ReportChartCard(title: 'Top Categories', icon: Icons.pie_chart_outline)),
              ],
            )
          else
            Column(
              children: [
                _ReportChartCard(title: 'Sales Trend', icon: Icons.show_chart),
                const SizedBox(height: 24),
                _ReportChartCard(title: 'Top Categories', icon: Icons.pie_chart_outline),
              ],
            ),
          const SizedBox(height: 32),
          // Top Products Table
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F172A).withValues(alpha: 0.06),
                  offset: const Offset(0, 4),
                  blurRadius: 20,
                  spreadRadius: -2,
                )
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Top Selling Products',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF131B2E),
                  ),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingTextStyle: const TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF475569)),
                    dataTextStyle: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xFF131B2E)),
                    columns: const [
                      DataColumn(label: Text('Product')),
                      DataColumn(label: Text('Units Sold')),
                      DataColumn(label: Text('Revenue')),
                      DataColumn(label: Text('Growth')),
                    ],
                    rows: _topProducts.map((p) {
                      final isPositive = p['growth']!.startsWith('+');
                      return DataRow(cells: [
                        DataCell(Text(p['name']!, style: const TextStyle(fontWeight: FontWeight.w600))),
                        DataCell(Text(p['units']!)),
                        DataCell(Text(p['revenue']!)),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: (isPositive ? const Color(0xFF10B981) : const Color(0xFFEF4444)).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            child: Text(
                              p['growth']!,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isPositive ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                              ),
                            ),
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, String>> _topProducts = [
  {'name': 'Wireless Headphones', 'units': '342', 'revenue': '\$102,258', 'growth': '+18.2%'},
  {'name': 'Smart Fitness Watch', 'units': '287', 'revenue': '\$57,113', 'growth': '+12.5%'},
  {'name': 'Leather Wallet', 'units': '256', 'revenue': '\$11,520', 'growth': '-3.1%'},
  {'name': 'Cotton T-Shirt', 'units': '198', 'revenue': '\$4,950', 'growth': '+7.8%'},
];

class _ReportChartCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _ReportChartCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.06),
            offset: const Offset(0, 4),
            blurRadius: 20,
            spreadRadius: -2,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF131B2E),
            ),
          ),
          const Spacer(),
          Center(child: Icon(icon, size: 64, color: const Color(0xFFE2E8F0))),
          const Spacer(),
        ],
      ),
    );
  }
}
