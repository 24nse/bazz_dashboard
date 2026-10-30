import 'package:flutter/material.dart';

class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0xFFF8FAFC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E7FF).withValues(alpha: 0.4)),
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
          const Text(
            'إجراءات سريعة تنفيذية',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF131B2E),
            ),
          ),
          const SizedBox(height: 12),
          _buildActionRow(
            'تصدير تقرير المبيعات (Excel/PDF)',
            Icons.file_download,
            const Color(0xFFECFDF5),
            const Color(0xFF059669),
          ),
          const SizedBox(height: 10),
          _buildActionRow(
            'إضافة كوبون خصم أو عرض ترويجي',
            Icons.sell,
            const Color(0xFFE2DFFF).withValues(alpha: 0.7),
            const Color(0xFF3525CD),
          ),
          const SizedBox(height: 10),
          _buildActionRow(
            'إرسال إشعار ترويجي لمستخدمي التطبيق',
            Icons.campaign,
            const Color(0xFFFFFBEB),
            const Color(0xFFD97706),
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow(String title, IconData icon, Color iconBgColor, Color iconColor) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E7FF)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF131B2E),
                  ),
                ),
              ],
            ),
            const Icon(Icons.chevron_left, color: Color(0xFF777587), size: 18),
          ],
        ),
      ),
    );
  }
}
