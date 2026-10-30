import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1024;
          final isTablet = constraints.maxWidth >= 768 && constraints.maxWidth < 1024;
          final isMobile = constraints.maxWidth < 768;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(isMobile, isTablet),
                const SizedBox(height: 24),
                _buildKPIs(isMobile, isTablet, isDesktop),
                const SizedBox(height: 24),
                _buildFilterBar(isMobile),
                const SizedBox(height: 24),
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildCategoriesList(isMobile),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: _buildAddCategoryDrawer(),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      _buildCategoriesList(isMobile),
                      const SizedBox(height: 24),
                      _buildAddCategoryDrawer(),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(bool isMobile, bool isTablet) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.03),
            blurRadius: 10.0,
            offset: const Offset(0, 2.0),
          )
        ],
      ),
      child: isMobile ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBreadcrumbs(),
          const SizedBox(height: 8),
          const Text('إدارة الأقسام والتصنيفات', style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF131B2E))),
          const SizedBox(height: 16),
          _buildHeaderActions(isMobile),
        ],
      ) : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBreadcrumbs(),
              const SizedBox(height: 4),
              const Text('إدارة الأقسام والتصنيفات', style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF131B2E))),
            ],
          ),
          _buildHeaderActions(isMobile),
        ],
      ),
    );
  }

  Widget _buildBreadcrumbs() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('لوحة الإدارة', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: Color(0xFF777587))),
        const SizedBox(width: 4),
        const Icon(Icons.chevron_left, size: 14, color: Color(0xFF777587)),
        const SizedBox(width: 4),
        const Text('الأقسام والتصنيفات', style: TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF131B2E))),
      ],
    );
  }

  Widget _buildHeaderActions(bool isMobile) {
    if (isMobile) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_circle, size: 20),
              label: const Text('+ إضافة قسم جديد'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                textStyle: const TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.download, size: 18),
          label: const Text('تصدير التقرير'),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF131B2E),
            side: const BorderSide(color: Color(0xFFC7C4D8)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: const TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.create_new_folder, size: 18),
          label: const Text('+ تصنيف فرعي'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE2DFFF),
            foregroundColor: const Color(0xFF3525CD),
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: const TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add_circle, size: 20),
          label: const Text('+ إضافة قسم رئيسي جديد'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4F46E5),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
            textStyle: const TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildKPIs(bool isMobile, bool isTablet, bool isDesktop) {
    int crossAxisCount = isDesktop ? 4 : (isTablet ? 2 : 1);
    return GridView.count(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: isMobile ? 2.5 : 2.2,
      children: [
        _buildKPICard('إجمالي الأقسام الرئيسية', '8', 'check_circle', 'جميعها نشطة ومزامنة', const Color(0xFF3525CD), const Color(0xFFF2F3FF), Icons.grid_view),
        _buildKPICard('إجمالي التصنيفات الفرعية', '46', 'tune', 'بمعدل 5.7 لكل قسم', const Color(0xFF855300), const Color(0xFFFFDDB8).withValues(alpha: 0.3), Icons.account_tree),
        _buildKPICard('إجمالي المنتجات المصنفة', '340', 'trending_up', '100% بدون تصنيف فارغ', const Color(0xFF3525CD), const Color(0xFFF2F3FF), Icons.shopping_bag),
        _buildKPICard('القسم الأكثر مبيعاً', 'أحذية وسنيكرز', 'stars', '42% من المبيعات', const Color(0xFFFEA619), const Color(0xFF684000).withValues(alpha: 0.1), Icons.insights, isOrange: true),
      ],
    );
  }

  Widget _buildKPICard(String title, String value, String subIcon, String subText, Color primaryColor, Color bgColor, IconData icon, {bool isOrange = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.06),
            blurRadius: 20.0,
            offset: const Offset(0, 4.0),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(fontFamily: 'Inter', fontSize: 13, color: Color(0xFF777587))),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF131B2E))),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(subIcon == 'check_circle' ? Icons.check_circle : (subIcon == 'tune' ? Icons.tune : (subIcon == 'trending_up' ? Icons.trending_up : Icons.stars)), size: 14, color: primaryColor),
                    const SizedBox(width: 4),
                    Expanded(child: Text(subText, style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: primaryColor, fontWeight: isOrange ? FontWeight.bold : FontWeight.normal), maxLines: 1, overflow: TextOverflow.ellipsis)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isOrange ? const Color(0xFFFFDDB8) : bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: isOrange ? const Color(0xFF2A1700) : primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.06),
            blurRadius: 20.0,
            offset: const Offset(0, 4.0),
          )
        ],
      ),
      child: isMobile ? Column(
        children: [
          _buildSearchBar(),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterPills(),
                const SizedBox(width: 12),
                _buildSortDropdown(),
              ],
            ),
          ),
        ],
      ) : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 384, child: _buildSearchBar()),
          Row(
            children: [
              _buildFilterPills(),
              const SizedBox(width: 16),
              Container(width: 1, height: 24, color: const Color(0xFFEAEDFF)),
              const SizedBox(width: 16),
              _buildSortDropdown(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F3FF),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF777587), size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'البحث باسم القسم، التصنيف الفرعي، أو الرابط...',
                hintStyle: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xFF777587)),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xFF131B2E)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterPills() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F3FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4.0,
                  offset: const Offset(0, 2.0),
                )
              ],
            ),
            child: const Text('الكل (8)', style: TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF3525CD))),
          ),
          const SizedBox(width: 4),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text('نشط (8)', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: Color(0xFF777587))),
          ),
          const SizedBox(width: 4),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text('معطل (0)', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: Color(0xFF777587))),
          ),
        ],
      ),
    );
  }

  Widget _buildSortDropdown() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('الترتيب:', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: Color(0xFF777587))),
        const SizedBox(width: 8),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F3FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: const [
              Text('الأكثر مبيعاً', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: Color(0xFF131B2E))),
              SizedBox(width: 8),
              Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF131B2E)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesList(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text('الأقسام الرئيسية الحالية', style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF131B2E))),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAEDFF),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: const Text('8 أقسام سحابية', style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587))),
                ),
              ],
            ),
            if (!isMobile)
              Row(
                children: const [
                  Icon(Icons.drag_indicator, size: 14, color: Color(0xFF777587)),
                  SizedBox(width: 4),
                  Text('اسحب لإعادة ترتيب الظهور في التطبيق', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: Color(0xFF777587))),
                ],
              ),
          ],
        ),
        const SizedBox(height: 16),
        _buildCategoryCard(
          title: 'أحذية وسنيكرز رياضية',
          badge: 'الأكثر طلباً 🔥',
          badgeColor: const Color(0xFFFFDDB8), // secondary-fixed
          badgeTextColor: const Color(0xFF2A1700), // on-secondary-fixed
          slug: '/shoes',
          engTitle: 'Athletic Footwear & Sneakers',
          productsCount: '94 منتج',
          sales: '42% من المبيعات',
          imgUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
          subs: ['رجالي (32)', 'نسائي (28)', 'أطفال وناشئين (14)', 'أحذية جري واحتراف (12)', 'سنيكرز كاجوال (8)'],
          isMobile: isMobile,
        ),
        const SizedBox(height: 16),
        _buildCategoryCard(
          title: 'إلكترونيات وسماعات',
          badge: 'مميز بالرئيسية',
          badgeColor: const Color(0xFFEAEDFF),
          badgeTextColor: const Color(0xFF3525CD),
          slug: '/electronics',
          engTitle: 'Electronics & Audio',
          productsCount: '62 منتج',
          sales: '24% من المبيعات',
          imgUrl: 'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb',
          subs: ['سماعات لاسلكية TWS (24)', 'سماعات محيطية الرأس (16)', 'شواحن وبنوك طاقة (12)', 'مكبرات صوت بلوتوث (10)'],
          isMobile: isMobile,
        ),
        const SizedBox(height: 16),
        _buildCategoryCard(
          title: 'أزياء وملابس رياضية',
          badge: null,
          badgeColor: Colors.transparent,
          badgeTextColor: Colors.transparent,
          slug: '/apparel',
          engTitle: 'Sportswear & Apparel',
          productsCount: '78 منتج',
          sales: '18% من المبيعات',
          imgUrl: 'https://images.unsplash.com/photo-1556821840-3a63f95609a7',
          subs: ['تيشيرتات تدريب (30)', 'بناطيل وشورتات رياضية (25)', 'سترات وجواكت واقية (23)'],
          isMobile: isMobile,
        ),
        const SizedBox(height: 16),
        _buildCategoryCard(
          title: 'ساعات ذكية وإكسسوارات',
          badge: null,
          badgeColor: Colors.transparent,
          badgeTextColor: Colors.transparent,
          slug: '/smartwatches',
          engTitle: 'Smartwatches & Tech Accessories',
          productsCount: '45 منتج',
          sales: '10% من المبيعات',
          imgUrl: 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a',
          subs: ['ساعات تدريب GPS (18)', 'أحزمة وأساور رياضية (15)', 'حمايات شاشة ومرفقات (12)'],
          isMobile: isMobile,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildSmallCategoryCard('حقائب ومعدات سفر', '35 منتج • 4 تصنيفات', Icons.backpack)),
            const SizedBox(width: 16),
            Expanded(child: _buildSmallCategoryCard('عطور وعناية شخصية', '27 منتج • 3 تصنيفات', Icons.spa)),
          ],
        )
      ],
    );
  }

  Widget _buildSmallCategoryCard(String title, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF2F3FF)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4.0,
            offset: const Offset(0, 2.0),
          )
        ],
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
                  color: const Color(0xFFEAEDFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: const Color(0xFF3525CD), size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontFamily: 'Inter', fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF131B2E))),
                  Text(subtitle, style: const TextStyle(fontFamily: 'Inter', fontSize: 12, color: Color(0xFF777587))),
                ],
              ),
            ],
          ),
          const Icon(Icons.chevron_left, color: Color(0xFF777587)),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required String? badge,
    required Color badgeColor,
    required Color badgeTextColor,
    required String slug,
    required String engTitle,
    required String productsCount,
    required String sales,
    required String imgUrl,
    required List<String> subs,
    required bool isMobile,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.transparent),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.06),
            blurRadius: 20.0,
            offset: const Offset(0, 4.0),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMobile) const Icon(Icons.drag_indicator, color: Color(0xFF777587), size: 20),
              if (!isMobile) const SizedBox(width: 16),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFEAEDFF),
                  image: DecorationImage(
                    image: NetworkImage(imgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(child: Text(title, style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF131B2E)))),
                        if (badge != null) const SizedBox(width: 8),
                        if (badge != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: badgeColor,
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: Text(badge, style: TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.bold, color: badgeTextColor)),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(slug, style: const TextStyle(fontFamily: 'monospace', fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF3525CD))),
                        const SizedBox(width: 12),
                        const Text('•', style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xFF777587))),
                        const SizedBox(width: 12),
                        Flexible(child: Text(engTitle, style: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xFF777587)), overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ],
                ),
              ),
              if (!isMobile)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(productsCount, style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF131B2E))),
                        Text(sales, style: const TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF3525CD))),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Switch(value: true, onChanged: (v) {}, activeColor: const Color(0xFF4F46E5)),
                    const SizedBox(width: 16),
                    Container(
                      decoration: BoxDecoration(color: const Color(0xFFF2F3FF), borderRadius: BorderRadius.circular(8)),
                      child: IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: () {}, color: const Color(0xFF131B2E), constraints: const BoxConstraints(minWidth: 32, minHeight: 32), padding: EdgeInsets.zero),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      decoration: BoxDecoration(color: const Color(0xFFF2F3FF), borderRadius: BorderRadius.circular(8)),
                      child: IconButton(icon: const Icon(Icons.archive, size: 18), onPressed: () {}, color: const Color(0xFF131B2E), constraints: const BoxConstraints(minWidth: 32, minHeight: 32), padding: EdgeInsets.zero),
                    ),
                  ],
                ),
            ],
          ),
          if (isMobile) const SizedBox(height: 16),
          if (isMobile)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(productsCount, style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF131B2E))),
                    Text(sales, style: const TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF3525CD))),
                  ],
                ),
                Row(
                  children: [
                    Switch(value: true, onChanged: (v) {}, activeColor: const Color(0xFF4F46E5)),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(color: const Color(0xFFF2F3FF), borderRadius: BorderRadius.circular(8)),
                      child: IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: () {}, color: const Color(0xFF131B2E), constraints: const BoxConstraints(minWidth: 32, minHeight: 32), padding: EdgeInsets.zero),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      decoration: BoxDecoration(color: const Color(0xFFF2F3FF), borderRadius: BorderRadius.circular(8)),
                      child: IconButton(icon: const Icon(Icons.archive, size: 18), onPressed: () {}, color: const Color(0xFF131B2E), constraints: const BoxConstraints(minWidth: 32, minHeight: 32), padding: EdgeInsets.zero),
                    ),
                  ],
                ),
              ],
            ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFF2F3FF), height: 1),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('التصنيفات الفرعية المرتبطة (${subs.length}):', style: const TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587))),
              Row(
                children: const [
                  Icon(Icons.add, size: 14, color: Color(0xFF3525CD)),
                  SizedBox(width: 4),
                  Text('إضافة تصنيف فرعي', style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF3525CD))),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: subs.map((sub) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F3FF),
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(sub, style: const TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF131B2E))),
                    const SizedBox(width: 6),
                    const Icon(Icons.close, size: 12, color: Color(0xFF777587)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCategoryDrawer() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF2F3FF)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.10),
            blurRadius: 25.0,
            offset: const Offset(0, 10.0),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('إضافة قسم رئيسي جديد', style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF131B2E))),
                  SizedBox(height: 2),
                  Text('رفع فوري وحفظ مباشر على Firestore', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: Color(0xFF777587))),
                ],
              ),
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFE2DFFF),
                  shape: BoxShape.circle,
                ),
                child: const Center(child: Text('+', style: TextStyle(color: Color(0xFF3525CD), fontWeight: FontWeight.bold))),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFEAEDFF), height: 1),
          const SizedBox(height: 24),
          
          const Text('صورة وغلاف القسم (Banner)', style: TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF131B2E))),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F3FF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFC7C4D8), style: BorderStyle.solid),
            ),
            child: Center(
              child: Column(
                children: const [
                  Icon(Icons.cloud_upload, color: Color(0xFF4F46E5), size: 32),
                  SizedBox(height: 8),
                  Text('اسحب الصورة هنا أو تصفح الملفات', style: TextStyle(fontFamily: 'Inter', fontSize: 13, color: Color(0xFF131B2E))),
                  SizedBox(height: 4),
                  Text('يدعم WebP, PNG, JPG', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: Color(0xFF777587))),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          _buildInputLabel('اسم القسم بالعربية', isRequired: true),
          const SizedBox(height: 6),
          _buildTextField('مثال: أحذية وسنيكرز رياضية'),
          const SizedBox(height: 16),
          
          _buildInputLabel('اسم القسم بالإنجليزية', isRequired: true),
          const SizedBox(height: 6),
          _buildTextField('e.g. Athletic Shoes & Sneakers', isLtr: true),
          const SizedBox(height: 16),
          
          _buildInputLabel('الرابط المخصص (Slug / URL)', isRequired: false),
          const SizedBox(height: 6),
          _buildTextField('shoes', isLtr: true, prefix: 'pulse-pro.store/c/'),
          const SizedBox(height: 16),
          
          _buildInputLabel('القسم الرئيسي الأب (Parent Category)', isRequired: false),
          const SizedBox(height: 6),
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFC7C4D8)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('بدون (قسم رئيسي أعلى Level 1)', style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xFF131B2E))),
                Icon(Icons.keyboard_arrow_down, color: Color(0xFF777587)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputLabel('ترتيب العرض', isRequired: false),
                    const SizedBox(height: 6),
                    _buildTextField('1'),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('مميز بالرئيسية', style: TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF131B2E))),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Switch(value: false, onChanged: (v) {}, activeColor: const Color(0xFF4F46E5)),
                        const Text('لا', style: TextStyle(fontFamily: 'Inter', fontSize: 13, color: Color(0xFF777587))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                textStyle: const TextStyle(fontFamily: 'Inter', fontSize: 15, fontWeight: FontWeight.bold),
              ),
              child: const Text('حفظ ونشر القسم'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputLabel(String label, {required bool isRequired}) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF131B2E))),
        if (isRequired) const Text(' *', style: TextStyle(color: Color(0xFFBA1A1A))),
      ],
    );
  }

  Widget _buildTextField(String hint, {bool isLtr = false, String? prefix}) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC7C4D8)),
      ),
      child: Row(
        textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
        children: [
          if (prefix != null) Text(prefix, style: const TextStyle(fontFamily: 'monospace', fontSize: 14, color: Color(0xFF777587))),
          Expanded(
            child: TextField(
              textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
              decoration: InputDecoration(
                hintText: hint,
                hintTextDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
                hintStyle: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xFF777587)),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xFF131B2E)),
            ),
          ),
        ],
      ),
    );
  }
}
