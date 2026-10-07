import 'package:flutter/material.dart';

class RevenueChartCard extends StatelessWidget {
  const RevenueChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E7FF)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFF3525CD), shape: BoxShape.circle)),
                        const SizedBox(width: 8),
                        const Text(
                          'تحليل وتطور الإيرادات والمبيعات',
                          style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF131B2E)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'مقارنة الإيرادات الفعلية مع المستهدف الشهري (2025)',
                      style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: Color(0xFF777587)),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Container(width: 12, height: 12, decoration: const BoxDecoration(color: Color(0xFF3525CD), shape: BoxShape.circle)),
                      const SizedBox(width: 8),
                      const Text('المبيعات الفعلية', style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF131B2E))),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Row(
                    children: [
                      Container(width: 12, height: 12, decoration: const BoxDecoration(color: Color(0xFFE2E7FF), shape: BoxShape.circle)),
                      const SizedBox(width: 8),
                      const Text('الهدف المحدد', style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587))),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: const Color(0xFFF2F3FF), borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.more_vert, size: 18, color: Color(0xFF777587)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Placeholder for the chart
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E7FF), style: BorderStyle.solid),
            ),
            child: const Center(
              child: Text(
                'Chart Visualization Area',
                style: TextStyle(color: Color(0xFF94A3B8), fontFamily: 'Inter', fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Months
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('يناير', style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587))),
              Text('فبراير', style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587))),
              Text('مارس', style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587))),
              Text('أبريل', style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587))),
              BadgeMonthWidget(text: 'مايو (الحالي)'),
              Text('يونيو', style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587))),
              Text('يوليو', style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587))),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(color: Color(0xFFE2E7FF), height: 1),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: const [
                    Text('أعلى يوم مبيعاً', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: Color(0xFF777587))),
                    SizedBox(height: 4),
                    Text('الخميس (24,800 ر.س)', style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF131B2E))),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: const [
                    Text('نسبة تحقيق الهدف', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: Color(0xFF777587))),
                    SizedBox(height: 4),
                    Text('92.4%', style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF059669))),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: const [
                    Text('التحويل من الإعلانات', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: Color(0xFF777587))),
                    SizedBox(height: 4),
                    Text('4.8%', style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF3525CD))),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BadgeMonthWidget extends StatelessWidget {
  final String text;
  const BadgeMonthWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF3525CD).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        text,
        style: const TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF3525CD)),
      ),
    );
  }
}

class CategorySalesCard extends StatelessWidget {
  const CategorySalesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E7FF)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'مبيعات الفئات والتصنيفات',
                style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF131B2E)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFF2F3FF), borderRadius: BorderRadius.circular(6)),
                child: const Text('هذا الشهر', style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587))),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'نسبة مساهمة كل قسم في إجمالي المبيعات المحققة.',
            style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: Color(0xFF777587)),
          ),
          const SizedBox(height: 24),
          // Donut Placeholder
          Center(
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF3525CD), width: 14),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('الأعلى مبيعاً', style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587))),
                    Text('42%', style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF131B2E))),
                    Text('أحذية رياضية', style: TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF3525CD))),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Divider(color: Color(0xFFE2E7FF), height: 1),
          const SizedBox(height: 16),
          _buildCategoryRow('أحذية وسنيكرز رياضية', '42%', '(62,546 ر.س)', const Color(0xFF3525CD)),
          const SizedBox(height: 12),
          _buildCategoryRow('إلكترونيات وسماعات', '28%', '(41,697 ر.س)', const Color(0xFFF59E0B)),
          const SizedBox(height: 12),
          _buildCategoryRow('أزياء وملابس شبابية', '18%', '(26,805 ر.س)', const Color(0xFFEF4444)),
          const SizedBox(height: 12),
          _buildCategoryRow('إكسسوارات وساعات', '12%', '(17,872 ر.س)', const Color(0xFFA5B4FC)),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(String name, String percent, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 10),
            Text(name, style: const TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF131B2E))),
          ],
        ),
        Row(
          children: [
            Text(percent, style: const TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF131B2E))),
            const SizedBox(width: 8),
            Text(value, style: const TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587))),
          ],
        ),
      ],
    );
  }
}
