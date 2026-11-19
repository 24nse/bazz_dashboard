import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';

import '../features/inventory/presentation/providers/inventory_providers.dart';

/// Top / Recent Products card for Dashboard, displaying live products from Firestore.
class TopProducts extends StatelessComponent {
  const TopProducts({super.key});

  @override
  Component build(BuildContext context) {
    final productsAsync = context.watch(productsNotifierProvider);
    final products = productsAsync.value ?? [];

    return div(
      classes:
          'bg-surface-container-lowest p-space-lg rounded-2xl shadow-[0_4px_20px_-2px_rgba(15,23,42,0.06)] border border-surface-container-high/40',
      [
        div(classes: 'flex items-center justify-between mb-4', [
          h3(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface', [
            Component.text('أحدث المنتجات والمخزون'),
          ]),
          a(
            classes: 'font-label-sm text-label-sm text-primary font-bold hover:underline',
            href: '/products',
            [Component.text('عرض الكل')],
          ),
        ]),
        div(classes: 'space-y-3.5', [
          if (products.isEmpty)
            div(classes: 'p-6 text-center text-outline text-body-sm', [
              Component.text(productsAsync.isLoading ? 'جارٍ تحميل البيانات...' : 'لا توجد منتجات مسجلة حتى الآن.'),
            ])
          else
            for (final product in products.take(4))
              div(classes: 'flex items-center justify-between p-2 rounded-xl hover:bg-surface-container-low transition-colors', [
                div(classes: 'flex items-center gap-3', [
                  div(classes: 'w-12 h-12 rounded-xl bg-surface-container-low p-1.5 flex-shrink-0 flex items-center justify-center overflow-hidden border border-surface-container', [
                    img(
                      classes: 'w-full h-full object-cover rounded-lg',
                      src: product.imageUrl,
                      alt: product.displayName,
                    ),
                  ]),
                  div([
                    h4(classes: 'font-label-md text-label-md font-bold text-on-surface leading-snug', [
                      Component.text(product.displayName),
                    ]),
                    span(classes: 'text-outline font-label-sm text-[11px]', [
                      Component.text('المخزون: ${product.stock} قطعة ${product.isLowStock ? "• (منخفض)" : ""}'),
                    ]),
                  ]),
                ]),
                div(classes: 'text-left font-price-sm', [
                  span(classes: 'font-bold text-on-surface block text-label-md', [
                    Component.text('${product.effectivePrice} ر.س'),
                  ]),
                  span(
                    classes: product.isPublished ? 'text-emerald-600 text-[11px] font-bold' : 'text-outline text-[11px]',
                    [Component.text(product.isPublished ? 'نشط' : 'مسودة')],
                  ),
                ]),
              ]),
        ]),
      ],
    );
  }
}
