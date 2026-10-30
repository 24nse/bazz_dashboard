import 'package:flutter/material.dart';

class TopProductsCard extends StatelessWidget {
  const TopProductsCard({super.key});

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
                'المنتجات الأكثر مبيعاً',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF131B2E),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Text(
                  'عرض التقارير',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3525CD),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildProductRow(
            'حذاء رياضي نايكي آير',
            'تم بيع 184 وحدة • متبقي: 42',
            '649 ر.س',
            '+28%',
            const Color(0xFF059669),
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBkOwS5BpW80H-NHhqc83STQmGm2uu4iafc-16QQ0ZM0qC6x1_2NDpWGXpM6c33DM320KTiu0UzsGWMbpgj-Qtk_6NjEyt0rcyie9pJTQbMJoasmjM4E7Ppd_Gggu-hldv48akNM-IopvFyC3icbliNd925h_8TQWDo8CcnNkhhHc28oyqK5CbEyvmbYTgp_cQSjyqVoPpgZBqqvPAXnIFemDzSxAqgVsDFoD3syK7Jph3f0rYBbFi5',
          ),
          const SizedBox(height: 12),
          _buildProductRow(
            'سماعات سوني WH-1000XM5',
            'تم بيع 129 وحدة • متبقي: 18',
            '1,120 ر.س',
            '+19%',
            const Color(0xFF059669),
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBB8owUe1GOZ3y-fiNi_a5elBttQ5rTYnIKRuk7XAL5Mma3nqiOB_c1xWHAM7M3CjMe1693Q8Uo6a1qSAlA8WMTfMLdVxoqUncXmBkgcze3csUsQs-X2iQCRb_taXea3evqiVjPOHHelc5-LLKrJz2U8apaViNfwqZ4YcYIpLEAM0315bo0VMonVkNXtfvGleu8IKz2OcDsCai4dPCyuWSZ5wNwmqumUlMeBU8VQ2TEtRhlNKlvjdzF',
          ),
          const SizedBox(height: 12),
          _buildProductRow(
            'ساعة أبل الذكية الجيل 9',
            'تم بيع 94 وحدة • متبقي: 6 (تنبيه)',
            '1,890 ر.س',
            '+12%',
            const Color(0xFF059669),
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDL3rhUiX8SLJKcn4_6y2Axfcx1jnL3SutIpRHR7ih9z3hrdrlCS0l9504diCNVNR47F6ChWQjDDVf5nx2PPxp2yuPTU-qGSeh1lyE9HMcxPaoxB_8HVoXMRKMTD8hstpQTd_yVwOV1ZVltO6M_MSZsgo-c18LnOX3zWbGS1cIVlGFldQudQVec6oJ4D6vBmaHJDhqtf_y3hT34i6-mjBRxLqM9-lKYoVrnqpgfVm24OlTHjovavG9w',
          ),
        ],
      ),
    );
  }

  Widget _buildProductRow(String title, String subtitle, String price, String growth, Color growthColor, String imageUrl) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E7FF)),
                  ),
                  child: Image.network(imageUrl, fit: BoxFit.contain),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF131B2E)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587)),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  price,
                  style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF131B2E)),
                ),
                const SizedBox(height: 2),
                Text(
                  growth,
                  style: TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.bold, color: growthColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
