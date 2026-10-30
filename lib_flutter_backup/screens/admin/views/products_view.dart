import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/providers/product_provider.dart';
import '../../../data/models/product.dart';

// Helper for formatting price
String _formatPrice(double price) {
  return '${price.toStringAsFixed(0)} ر.س';
}

class ProductsView extends ConsumerWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;

          return productsAsync.when(
            data: (products) {
              if (isMobile) {
                return _ProductsMobileView(products: products);
              } else {
                return _ProductsDesktopView(products: products, constraints: constraints);
              }
            },
            loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF3525CD))),
            error: (e, st) => const Center(child: Text('حدث خطأ', style: TextStyle(fontFamily: 'Plus Jakarta Sans'))),
          );
        },
      ),
    );
  }
}

class _ProductsDesktopView extends StatelessWidget {
  final List<Product> products;
  final BoxConstraints constraints;

  const _ProductsDesktopView({required this.products, required this.constraints});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StatCardsRow(products: products, constraints: constraints),
            const SizedBox(height: 24),
            const _FilterBar(),
            const SizedBox(height: 24),
            _ProductsTable(products: products),
          ],
        ),
      ),
    );
  }
}

class _StatCardsRow extends StatelessWidget {
  final List<Product> products;
  final BoxConstraints constraints;

  const _StatCardsRow({required this.products, required this.constraints});

  @override
  Widget build(BuildContext context) {
    final activeProducts = products.where((p) => p.stock > 0).length;
    final lowStock = products.where((p) => p.stock > 0 && p.stock <= 10).length;
    final outOfStock = products.where((p) => p.stock == 0).length;

    // Responsive width for KPI cards
    final double cardWidth = (constraints.maxWidth - (24 * 2) - (16 * 3)) / 4;
    final isCompact = cardWidth < 200;

    return isCompact 
      ? Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            SizedBox(
              width: (constraints.maxWidth - 48 - 16) / 2,
              child: _StatCard(
                title: 'إجمالي المنتجات',
                value: '${products.length}',
                subtitle: '+14 هذا الشهر',
                subtitleColor: const Color(0xFF10B981),
                iconData: Icons.inventory_2,
                iconColor: const Color(0xFF3525CD),
                iconBg: const Color(0xFFE2DFFF).withValues(alpha: 0.5),
              ),
            ),
            SizedBox(
              width: (constraints.maxWidth - 48 - 16) / 2,
              child: _StatCard(
                title: 'منتجات نشطة بالمتجر',
                value: '$activeProducts',
                subtitle: '91.7% نسبة التوفر',
                subtitleColor: const Color(0xFF10B981),
                iconData: Icons.visibility,
                iconColor: const Color(0xFF047857),
                iconBg: const Color(0xFFECFDF5),
              ),
            ),
            SizedBox(
              width: (constraints.maxWidth - 48 - 16) / 2,
              child: _StatCard(
                title: 'أوشك على النفاد',
                value: '$lowStock',
                subtitle: 'يحتاج طلب توريد',
                subtitleColor: const Color(0xFF855300),
                valueColor: const Color(0xFFFEA619),
                iconData: Icons.warning_amber_rounded,
                iconColor: const Color(0xFF855300),
                iconBg: const Color(0xFFFFDDB8).withValues(alpha: 0.4),
              ),
            ),
            SizedBox(
              width: (constraints.maxWidth - 48 - 16) / 2,
              child: _StatCard(
                title: 'نفدت الكمية تماماً',
                value: '$outOfStock',
                subtitle: 'مخفي من المتجر',
                subtitleColor: const Color(0xFFBA1A1A),
                valueColor: const Color(0xFFBA1A1A),
                iconData: Icons.remove_shopping_cart,
                iconColor: const Color(0xFFBA1A1A),
                iconBg: const Color(0xFFFFDAD6).withValues(alpha: 0.4),
              ),
            ),
          ],
        )
      : Row(
          children: [
            Expanded(child: _StatCard(
              title: 'إجمالي المنتجات',
              value: '${products.length}',
              subtitle: '+14 هذا الشهر',
              subtitleColor: const Color(0xFF10B981),
              iconData: Icons.inventory_2,
              iconColor: const Color(0xFF3525CD),
              iconBg: const Color(0xFFE2DFFF).withValues(alpha: 0.5),
            )),
            const SizedBox(width: 16),
            Expanded(child: _StatCard(
              title: 'منتجات نشطة بالمتجر',
              value: '$activeProducts',
              subtitle: '91.7% نسبة التوفر',
              subtitleColor: const Color(0xFF10B981),
              iconData: Icons.visibility,
              iconColor: const Color(0xFF047857),
              iconBg: const Color(0xFFECFDF5),
            )),
            const SizedBox(width: 16),
            Expanded(child: _StatCard(
              title: 'أوشك على النفاد',
              value: '$lowStock',
              subtitle: 'يحتاج طلب توريد',
              subtitleColor: const Color(0xFF855300),
              valueColor: const Color(0xFFFEA619),
              iconData: Icons.warning_amber_rounded,
              iconColor: const Color(0xFF855300),
              iconBg: const Color(0xFFFFDDB8).withValues(alpha: 0.4),
            )),
            const SizedBox(width: 16),
            Expanded(child: _StatCard(
              title: 'نفدت الكمية تماماً',
              value: '$outOfStock',
              subtitle: 'مخفي من المتجر',
              subtitleColor: const Color(0xFFBA1A1A),
              valueColor: const Color(0xFFBA1A1A),
              iconData: Icons.remove_shopping_cart,
              iconColor: const Color(0xFFBA1A1A),
              iconBg: const Color(0xFFFFDAD6).withValues(alpha: 0.4),
            )),
          ],
        );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color subtitleColor;
  final IconData iconData;
  final Color iconColor;
  final Color iconBg;
  final Color? valueColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.subtitleColor,
    required this.iconData,
    required this.iconColor,
    required this.iconBg,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFC7C4D8).withValues(alpha: 0.3)),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title, 
                  style: const TextStyle(fontFamily: 'Inter', fontSize: 12, color: Color(0xFF464555)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  value, 
                  style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 22, fontWeight: FontWeight.w800, color: valueColor ?? const Color(0xFF131B2E)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.trending_up, size: 13, color: subtitleColor),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        subtitle, 
                        style: TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.w600, color: subtitleColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(iconData, color: iconColor),
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFC7C4D8).withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4.0,
            offset: const Offset(0, 2.0),
          )
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 700;
          
          if (isCompact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSearchInput(),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildDropdown('جميع الأقسام (الكل)', Icons.expand_more)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildDropdown('حالة المخزون: الكل', Icons.filter_list)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildOutlineButton(Icons.download, 'تصدير Excel'),
                    const SizedBox(width: 8),
                    _buildOutlineButton(Icons.upload_file, 'استيراد جماعي'),
                  ],
                )
              ],
            );
          }
          
          return Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: _buildSearchInput()),
                    const SizedBox(width: 12),
                    _buildDropdown('جميع الأقسام (الكل)', Icons.expand_more),
                    const SizedBox(width: 12),
                    _buildDropdown('حالة المخزون: الكل', Icons.filter_list),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  _buildOutlineButton(Icons.download, 'تصدير Excel'),
                  const SizedBox(width: 8),
                  _buildOutlineButton(Icons.upload_file, 'استيراد جماعي'),
                ],
              ),
            ],
          );
        }
      ),
    );
  }

  Widget _buildSearchInput() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFFAF8FF),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFC7C4D8).withValues(alpha: 0.6)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF777587), size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'البحث بالاسم، كود SKU، أو الماركة...',
                hintStyle: TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFF777587),
                  fontSize: 12,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(
                fontFamily: 'Inter',
                color: Color(0xFF131B2E),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String text, IconData icon) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF8FF),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFC7C4D8).withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(text, style: const TextStyle(fontFamily: 'Inter', fontSize: 12, color: Color(0xFF131B2E)), overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 12),
          Icon(icon, color: const Color(0xFF777587), size: 18),
        ],
      ),
    );
  }

  Widget _buildOutlineButton(IconData icon, String text) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF8FF),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFC7C4D8).withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF131B2E)),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF131B2E))),
        ],
      ),
    );
  }
}

class _ProductsTable extends StatelessWidget {
  final List<Product> products;

  const _ProductsTable({required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFC7C4D8).withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4.0,
            offset: const Offset(0, 2.0),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 900),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF8FF),
                  border: Border(bottom: BorderSide(color: const Color(0xFFC7C4D8).withValues(alpha: 0.3))),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Row(
                  children: const [
                    SizedBox(width: 48, child: Icon(Icons.check_box_outline_blank, color: Color(0xFFC7C4D8), size: 20)),
                    SizedBox(width: 250, child: Text('المنتج والتفاصيل', style: TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF464555)))),
                    SizedBox(width: 150, child: Text('القسم / التصنيف', style: TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF464555)))),
                    SizedBox(width: 100, child: Text('السعر', style: TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF464555)))),
                    SizedBox(width: 180, child: Text('حالة المخزون', style: TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF464555)))),
                    SizedBox(width: 100, child: Text('المبيعات', style: TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF464555)))),
                    SizedBox(width: 100, child: Center(child: Text('حالة النشر', style: TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF464555))))),
                    SizedBox(width: 100, child: Center(child: Text('الإجراءات', style: TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF464555))))),
                  ],
                ),
              ),
            ),
          ),
          // Rows
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 900),
              child: Column(
                children: products.map((p) => _DesktopTableRow(product: p)).toList(),
              ),
            ),
          ),
          // Pagination
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: const Color(0xFFC7C4D8).withValues(alpha: 0.3))),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              runSpacing: 16,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'عرض ',
                    style: const TextStyle(fontFamily: 'Inter', fontSize: 12, color: Color(0xFF464555)),
                    children: [
                      const TextSpan(text: '1 - 4', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF131B2E))),
                      const TextSpan(text: ' من أصل '),
                      TextSpan(text: '${products.length}', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF131B2E))),
                      const TextSpan(text: ' منتج'),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildPaginationButton(Icons.chevron_right, false),
                    const SizedBox(width: 4),
                    _buildPageNumber('1', true),
                    const SizedBox(width: 4),
                    _buildPageNumber('2', false),
                    const SizedBox(width: 4),
                    _buildPageNumber('3', false),
                    const SizedBox(width: 4),
                    const Text('...', style: TextStyle(color: Color(0xFF777587))),
                    const SizedBox(width: 4),
                    _buildPageNumber('34', false),
                    const SizedBox(width: 4),
                    _buildPaginationButton(Icons.chevron_left, true),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationButton(IconData icon, bool enabled) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFC7C4D8).withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(8),
        color: enabled ? Colors.transparent : const Color(0xFFFAF8FF).withValues(alpha: 0.5),
      ),
      child: Icon(icon, size: 18, color: enabled ? const Color(0xFF131B2E) : const Color(0xFF777587).withValues(alpha: 0.4)),
    );
  }

  Widget _buildPageNumber(String num, bool isActive) {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF3525CD) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(num, style: TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: isActive ? FontWeight.bold : FontWeight.w600, color: isActive ? Colors.white : const Color(0xFF131B2E))),
    );
  }
}

class _DesktopTableRow extends StatelessWidget {
  final Product product;

  const _DesktopTableRow({required this.product});

  @override
  Widget build(BuildContext context) {
    Color stockColor;
    String stockLabel;
    double stockPercent;
    if (product.stock > 10) {
      stockColor = const Color(0xFF10B981);
      stockLabel = 'متوفر (${product.stock} قطعة)';
      stockPercent = 0.78;
    } else if (product.stock > 0) {
      stockColor = const Color(0xFFFEA619);
      stockLabel = 'منخفض (${product.stock} قطع فقط)';
      stockPercent = 0.15;
    } else {
      stockColor = const Color(0xFFBA1A1A);
      stockLabel = 'نفذت الكمية (0)';
      stockPercent = 0.0;
    }

    return Container(
      width: 1028, // minWidth defined in ConstrainedBox + padding
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: const Color(0xFFC7C4D8).withValues(alpha: 0.2))),
        color: product.stock == 0 ? const Color(0xFFFAF8FF).withValues(alpha: 0.4) : Colors.transparent,
      ),
      child: Row(
        children: [
          const SizedBox(width: 48, child: Icon(Icons.check_box_outline_blank, color: Color(0xFFC7C4D8), size: 20)),
          SizedBox(
            width: 250,
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFC7C4D8).withValues(alpha: 0.4)),
                    color: const Color(0xFFEAEDFF),
                    image: DecorationImage(
                      image: NetworkImage(product.imageUrl), 
                      fit: BoxFit.cover,
                      colorFilter: product.stock == 0 ? const ColorFilter.matrix(<double>[
                        0.2126, 0.7152, 0.0722, 0, 0,
                        0.2126, 0.7152, 0.0722, 0, 0,
                        0.2126, 0.7152, 0.0722, 0, 0,
                        0,      0,      0,      1, 0,
                      ]) : null,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(product.name, style: const TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF131B2E)), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAEDFF),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text('SKU: PRD-${product.id.substring(0,4).toUpperCase()}', style: const TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF464555))),
                          ),
                          const SizedBox(width: 8),
                          const Expanded(child: Text('الماركة: متجر نبض', style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF464555)), maxLines: 1, overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 150,
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAEDFF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(product.category, style: const TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF131B2E)), maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_formatPrice(product.price), style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF131B2E))),
                Text('${(product.price * 1.15).toStringAsFixed(0)} ر.س', style: const TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587), decoration: TextDecoration.lineThrough)),
              ],
            ),
          ),
          SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: stockColor)),
                    const SizedBox(width: 6),
                    Expanded(child: Text(stockLabel, style: TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600, color: stockColor), maxLines: 1, overflow: TextOverflow.ellipsis)),
                  ],
                ),
                const SizedBox(height: 6),
                Container(
                  width: 96,
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E7FF),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  alignment: AlignmentDirectional.centerStart,
                  child: FractionallySizedBox(
                    widthFactor: stockPercent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: stockColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 100, child: Text('1,420 طلب', style: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF131B2E)))),
          SizedBox(
            width: 100,
            child: Center(
              child: Switch(
                value: product.stock > 0,
                onChanged: (v) {},
                activeColor: const Color(0xFF3525CD),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: const Color(0xFFC7C4D8),
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.edit, size: 18, color: Color(0xFF464555)),
                SizedBox(width: 8),
                Icon(Icons.visibility, size: 18, color: Color(0xFF464555)),
                SizedBox(width: 8),
                Icon(Icons.delete, size: 18, color: Color(0xFF464555)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductsMobileView extends StatelessWidget {
  final List<Product> products;

  const _ProductsMobileView({required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF8FF),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward, color: Color(0xFF464555)),
          onPressed: () {},
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('إدارة المنتجات والمخزون', style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF131B2E))),
            Text('متجر الأناقة العصري • متصل', style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587))),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Color(0xFF464555)),
            onPressed: () {},
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(start: 16, end: 4),
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF3525CD),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _MobileSearchBar(),
          const SizedBox(height: 16),
          const _MobileFilterTabs(),
          const SizedBox(height: 16),
          const _MobileAlertCard(),
          const SizedBox(height: 16),
          // List Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(child: Text('المنتجات المعروضة (4 من أصل 142)', style: TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF464555)), maxLines: 1, overflow: TextOverflow.ellipsis)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.swap_vert, size: 18, color: Color(0xFF3525CD)),
                  SizedBox(width: 4),
                  Text('الأحدث تعديلاً', style: TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF3525CD))),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Product Cards
          ...products.map((p) => _MobileProductCard(product: p)),
        ],
      ),
    );
  }
}

class _MobileSearchBar extends StatelessWidget {
  const _MobileSearchBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 20.0,
                  offset: const Offset(0, 4.0),
                )
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.search, color: Color(0xFF777587), size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'البحث بالاسم، الكود SKU، أو الفئة...',
                      hintStyle: TextStyle(
                        fontFamily: 'Inter',
                        color: Color(0xFF777587),
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xFF131B2E),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 20.0,
                offset: const Offset(0, 4.0),
              )
            ],
          ),
          child: const Icon(Icons.qr_code_scanner, color: Color(0xFF3525CD)),
        ),
      ],
    );
  }
}

class _MobileFilterTabs extends StatelessWidget {
  const _MobileFilterTabs();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          _buildMobileTab('الكل', '142', true, const Color(0xFF4F46E5), Colors.white),
          const SizedBox(width: 8),
          _buildMobileTab('متوفر', '133', false, const Color(0xFFF2F3FF), const Color(0xFF464555)),
          const SizedBox(width: 8),
          _buildMobileTab('منخفض المخزون', '6', false, const Color(0xFFFFDDB8).withValues(alpha: 0.5), const Color(0xFF855300), isPulse: true),
          const SizedBox(width: 8),
          _buildMobileTab('نفذت الكمية', '3', false, const Color(0xFFFFDAD6).withValues(alpha: 0.6), const Color(0xFFBA1A1A)),
        ],
      ),
    );
  }

  Widget _buildMobileTab(String label, String count, bool active, Color bg, Color textC, {bool isPulse = false}) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isPulse) ...[
            Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFFEA619))),
            const SizedBox(width: 6),
          ],
          Text(label, style: TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600, color: textC)),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: active ? Colors.white.withValues(alpha: 0.2) : const Color(0xFFDAE2FD),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(count, style: TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.bold, color: textC)),
          ),
        ],
      ),
    );
  }
}

class _MobileAlertCard extends StatelessWidget {
  const _MobileAlertCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFFFFFFF), const Color(0xFFFFDDB8).withValues(alpha: 0.4)],
          begin: AlignmentDirectional.centerEnd,
          end: AlignmentDirectional.centerStart,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFDDB8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFFDDB8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.warning, color: Color(0xFF855300)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('تنبيه المخزون الحرج', style: TextStyle(fontFamily: 'Inter', fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF131B2E))),
                const SizedBox(height: 2),
                const Text('يوجد 6 منتجات قاربت على النفاد، يوصى بإعادة توريدها فوراً لتجنب توقف المبيعات.', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: Color(0xFF777587))),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEA619),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.autorenew, color: Color(0xFF684000), size: 16),
                          SizedBox(width: 4),
                          Text('تحديث الكميات سريعاً', style: TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF684000))),
                        ],
                      ),
                    ),
                    const Text('تجاهل', style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileProductCard extends StatelessWidget {
  final Product product;

  const _MobileProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final bool isCritical = product.stock > 0 && product.stock <= 10;
    final bool isOut = product.stock == 0;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isOut ? const Color(0xFFFFFFFF).withValues(alpha: 0.8) : const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isOut ? const Color(0xFFFFDAD6).withValues(alpha: 0.8) : const Color(0xFFEAEDFF)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20.0,
            offset: const Offset(0, 4.0),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFF2F3FF),
                  image: DecorationImage(image: NetworkImage(product.imageUrl), fit: BoxFit.cover, colorFilter: isOut ? const ColorFilter.matrix(<double>[
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0,      0,      0,      1, 0,
                  ]) : null),
                ),
                child: isCritical ? Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFBC1D25).withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text('مخزون حرج', style: TextStyle(fontFamily: 'Inter', fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ) : (isOut ? Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFBA1A1A),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text('نفذ', style: TextStyle(fontFamily: 'Inter', fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ) : null),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(product.name, style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF131B2E)), maxLines: 1, overflow: TextOverflow.ellipsis)),
                        const Icon(Icons.more_vert, size: 20, color: Color(0xFF777587)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(child: Text('SKU: PRD-${product.id.substring(0,4).toUpperCase()}', style: const TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587)), maxLines: 1, overflow: TextOverflow.ellipsis)),
                        Container(margin: const EdgeInsets.symmetric(horizontal: 8), width: 4, height: 4, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFC7C4D8))),
                        const Text('48 طلب', style: TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF855300))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(product.price.toStringAsFixed(0), style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 15, fontWeight: FontWeight.w700, color: isOut ? const Color(0xFF131B2E) : const Color(0xFF3525CD))),
                            const SizedBox(width: 4),
                            const Text('ر.س', style: TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF777587))),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            color: isOut ? const Color(0xFFFFDAD6) : const Color(0xFFFFDDB8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(width: 6, height: 6, decoration: BoxDecoration(shape: BoxShape.circle, color: isOut ? const Color(0xFFBA1A1A) : const Color(0xFF855300))),
                              const SizedBox(width: 4),
                              Text(isOut ? 'نفذت الكمية (0)' : '${product.stock} قطع متبقية', style: TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.bold, color: isOut ? const Color(0xFF93000A) : const Color(0xFF653E00))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.only(top: 12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFEAEDFF))),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                if (isOut)
                  Container(
                    height: 32,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3525CD),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.add_box, color: Colors.white, size: 16),
                        SizedBox(width: 6),
                        Text('توريد سريع +10', style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Colors.white)),
                      ],
                    ),
                  )
                else
                  Container(
                    height: 32,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F3FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(width: 28, height: 28, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white), child: const Icon(Icons.remove, size: 16, color: Color(0xFF131B2E))),
                        SizedBox(width: 36, child: Center(child: Text('${product.stock}', style: const TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF131B2E))))),
                        Container(width: 28, height: 28, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white), child: const Icon(Icons.add, size: 16, color: Color(0xFF3525CD))),
                      ],
                    ),
                  ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('نشط', style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Color(0xFF777587))),
                    const SizedBox(width: 6),
                    Switch(
                      value: !isOut,
                      onChanged: (v) {},
                      activeColor: const Color(0xFF3525CD),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: const Color(0xFFC7C4D8),
                    ),
                    const SizedBox(width: 12),
                    Container(width: 32, height: 32, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFF2F3FF)), child: const Icon(Icons.edit, size: 18, color: Color(0xFF777587))),
                    const SizedBox(width: 12),
                    if (!isOut) Container(width: 32, height: 32, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFF2F3FF)), child: const Icon(Icons.share, size: 18, color: Color(0xFF777587))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
