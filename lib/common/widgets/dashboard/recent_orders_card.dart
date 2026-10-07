import 'package:flutter/material.dart';

class RecentOrdersCard extends StatelessWidget {
  const RecentOrdersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('أحدث الطلبات المستلمة', style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF131B2E))),
                    SizedBox(height: 4),
                    Text('تحديث فوري للطلبات الواردة من تطبيق المتجر', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: Color(0xFF777587))),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: const Color(0xFFF2F3FF), borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 2, offset: const Offset(0, 1))]),
                            child: const Text('الكل', style: TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF3525CD))),
                          ),
                          const SizedBox(width: 8),
                          const Text('قيد التجهيز', style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF464555))),
                          const SizedBox(width: 8),
                          const Text('تم الشحن', style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF464555))),
                          const SizedBox(width: 8),
                          const Text('مكتمل', style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF464555))),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text('عرض جميع الطلبات', style: TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF3525CD))),
                  ],
                ),
              ],
            ),
          ),
          
          // Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
              dataRowMinHeight: 70,
              dataRowMaxHeight: 70,
              headingTextStyle: const TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587), fontWeight: FontWeight.w600),
              columns: const [
                DataColumn(label: Text('رقم الطلب')),
                DataColumn(label: Text('العميل')),
                DataColumn(label: Text('التاريخ والوقت')),
                DataColumn(label: Text('المنتجات')),
                DataColumn(label: Text('الإجمالي')),
                DataColumn(label: Text('الحالة')),
                DataColumn(label: Text('الإجراءات')),
              ],
              rows: [
                _buildRow('#FLT-89432', 'سعد الدوسري', 'الرياض، المملكة', 'منذ 14 دقيقة', 'حذاء نايكي + جورب', '649 ر.س', 'قيد التجهيز', const Color(0xFFD97706), const Color(0xFFFFFBEB), const Color(0xFFFDE68A)),
                _buildRow('#FLT-89431', 'ريم العتيبي', 'جدة، المملكة', 'منذ 42 دقيقة', 'سماعات سوني اللاسلكية', '1,120 ر.س', 'تم الشحن', const Color(0xFF4338CA), const Color(0xFFEEF2FF), const Color(0xFFC7D2FE)),
                _buildRow('#FLT-89430', 'فيصل الشمري', 'الدمام، المملكة', 'منذ ساعتين', 'ساعة أبل الجيل التاسع', '1,890 ر.س', 'مكتمل ومستلم', const Color(0xFF059669), const Color(0xFFECFDF5), const Color(0xFFA7F3D0)),
                _buildRow('#FLT-89429', 'نوف القحطاني', 'أبها، المملكة', 'منذ 3 ساعات', 'حقيبة ظهر جلدية فاخرة', '320 ر.س', 'مدفوع - ينتظر الشحن', const Color(0xFF1D4ED8), const Color(0xFFEFF6FF), const Color(0xFFBFDBFE)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(String id, String name, String location, String time, String products, String total, String status, Color statusColor, Color statusBgColor, Color statusBorderColor) {
    return DataRow(
      cells: [
        DataCell(Text(id, style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF3525CD)))),
        DataCell(
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(color: Color(0xFFEAEDFF), shape: BoxShape.circle),
                child: const Icon(Icons.person, color: Color(0xFF3525CD), size: 18),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(name, style: const TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF131B2E))),
                  Text(location, style: const TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587))),
                ],
              ),
            ],
          ),
        ),
        DataCell(Text(time, style: const TextStyle(fontFamily: 'Inter', fontSize: 13, color: Color(0xFF777587)))),
        DataCell(Text(products, style: const TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF131B2E)))),
        DataCell(Text(total, style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF131B2E)))),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusBgColor,
              border: Border.all(color: statusBorderColor),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 6, height: 6, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
                const SizedBox(width: 6),
                Text(status, style: TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.bold, color: statusColor)),
              ],
            ),
          ),
        ),
        DataCell(
          Row(
            children: [
              IconButton(icon: const Icon(Icons.visibility, color: Color(0xFF777587), size: 18), onPressed: () {}),
              IconButton(icon: const Icon(Icons.print, color: Color(0xFF777587), size: 18), onPressed: () {}),
            ],
          ),
        ),
      ],
    );
  }
}
