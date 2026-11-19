import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';

import '../features/inventory/data/models/product_model.dart';
import '../features/inventory/presentation/providers/inventory_providers.dart';

/// The Products & Inventory Management Page in Jaspr for Matjar Nabdh.
/// Fully dynamic with Riverpod state management and live Firestore data.
class ProductsPage extends StatelessComponent {
  const ProductsPage({super.key});

  @override
  Component build(BuildContext context) {
    final productsAsync = context.watch(productsNotifierProvider);
    final totalProducts = context.watch(totalProductsCountProvider);
    final activeProducts = context.watch(activeProductsCountProvider);
    final lowStockProducts = context.watch(lowStockProductsCountProvider);
    final isLoading = productsAsync.isLoading;

    return main_(
      classes: 'flex-1 overflow-y-auto custom-scroll p-space-xl space-y-6',
      [
        // Top Breadcrumb & Page Title Bar
        div(classes: 'flex flex-wrap items-center justify-between gap-4 pb-2 border-b border-surface-container-high/40', [
          div(classes: 'flex flex-col gap-1', [
            div(classes: 'flex items-center gap-2 text-outline text-body-sm font-label-md', [
              a(
                classes: 'hover:text-primary transition-colors flex items-center gap-1',
                href: '/',
                [
                  span(classes: 'material-symbols-outlined text-[16px]', [Component.text('home')]),
                  Component.text('لوحة الإدارة'),
                ],
              ),
              span(classes: 'material-symbols-outlined text-[14px]', [Component.text('chevron_left')]),
              span(classes: 'text-primary font-bold', [Component.text('المنتجات والمخزون')]),
            ]),
            h1(classes: 'font-headline-md text-headline-md font-bold text-on-surface flex items-center gap-2.5', [
              div(classes: 'w-9 h-9 rounded-xl bg-primary flex items-center justify-center text-on-primary shadow-sm', [
                span(classes: 'material-symbols-outlined text-[20px]', [Component.text('inventory_2')]),
              ]),
              Component.text('إدارة المنتجات والمخزون'),
            ]),
          ]),

          div(classes: 'flex items-center gap-3', [
            button(
              classes:
                  'h-11 px-4 rounded-full border border-primary/30 hover:border-primary bg-primary/5 hover:bg-primary/10 text-primary font-label-md text-label-md font-bold flex items-center gap-2 transition-all cursor-pointer',
              events: {'click': (e) => context.read(productsNotifierProvider.notifier).refresh()},
              [
                span(classes: 'material-symbols-outlined text-[18px] ${isLoading ? "animate-spin" : ""}', [
                  Component.text('sync'),
                ]),
                span([Component.text(isLoading ? 'جارٍ المزامنة...' : 'مزامنة مع Firebase')]),
              ],
            ),
            a(
              classes:
                  'h-11 px-5 rounded-full bg-primary hover:bg-primary-container text-on-primary font-label-md text-label-md font-bold flex items-center gap-2 shadow-md shadow-primary/20 active:scale-95 transition-all',
              href: '/add-product',
              [
                span(classes: 'material-symbols-outlined text-[20px]', [Component.text('add')]),
                span([Component.text('إضافة منتج جديد')]),
              ],
            ),
          ]),
        ]),

        // KPI Summary Cards (4 Dynamic Cards)
        div(classes: 'grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4', [
          // Total Products
          div(
            classes:
                'bg-surface-container-lowest p-5 rounded-2xl border border-surface-container-high/40 shadow-sm flex items-center justify-between',
            [
              div([
                p(classes: 'font-body-sm text-body-sm text-outline', [Component.text('إجمالي المنتجات')]),
                h3(classes: 'font-price-lg text-price-lg text-on-surface mt-1 font-bold', [
                  Component.text('$totalProducts'),
                ]),
                span(
                  classes: 'text-[11px] text-emerald-600 font-semibold inline-flex items-center gap-0.5 mt-1',
                  [
                    span(classes: 'material-symbols-outlined text-[13px]', [Component.text('trending_up')]),
                    Component.text('محدث لحظياً'),
                  ],
                ),
              ]),
              div(
                classes:
                    'w-12 h-12 rounded-xl bg-primary-fixed/50 text-primary flex items-center justify-center shadow-sm',
                [
                  span(classes: 'material-symbols-outlined text-2xl', [Component.text('inventory_2')]),
                ],
              ),
            ],
          ),

          // Active Products
          div(
            classes:
                'bg-surface-container-lowest p-5 rounded-2xl border border-surface-container-high/40 shadow-sm flex items-center justify-between',
            [
              div([
                p(classes: 'font-body-sm text-body-sm text-outline', [Component.text('منتجات نشطة بالمتجر')]),
                h3(classes: 'font-price-lg text-price-lg text-on-surface mt-1 font-bold', [
                  Component.text('$activeProducts'),
                ]),
                span(
                  classes: 'text-[11px] text-emerald-600 font-semibold inline-flex items-center gap-0.5 mt-1',
                  [
                    span(classes: 'material-symbols-outlined text-[13px]', [Component.text('check_circle')]),
                    Component.text('نشطة في متجر نبض'),
                  ],
                ),
              ]),
              div(
                classes: 'w-12 h-12 rounded-xl bg-emerald-50 text-emerald-600 flex items-center justify-center shadow-sm',
                [
                  span(classes: 'material-symbols-outlined text-2xl', [Component.text('visibility')]),
                ],
              ),
            ],
          ),

          // Live Firestore Collection Count
          div(
            classes:
                'bg-surface-container-lowest p-5 rounded-2xl border-2 border-primary/30 shadow-sm flex items-center justify-between',
            [
              div([
                p(classes: 'font-body-sm text-body-sm text-primary font-bold', [Component.text('مستندات Firestore الحية')]),
                h3(classes: 'font-price-lg text-price-lg text-primary mt-1 font-bold', [
                  Component.text('${productsAsync.value?.length ?? 0}'),
                ]),
                span(
                  classes: 'text-[11px] text-emerald-600 font-semibold inline-flex items-center gap-0.5 mt-1',
                  [
                    span(classes: 'material-symbols-outlined text-[13px]', [Component.text('cloud_done')]),
                    Component.text('مجموعة /Products'),
                  ],
                ),
              ]),
              div(
                classes: 'w-12 h-12 rounded-xl bg-primary-fixed text-primary flex items-center justify-center shadow-sm',
                [
                  span(classes: 'material-symbols-outlined text-2xl', [Component.text('cloud_sync')]),
                ],
              ),
            ],
          ),

          // Stock Alert
          div(
            classes:
                'bg-surface-container-lowest p-5 rounded-2xl border border-surface-container-high/40 shadow-sm flex items-center justify-between',
            [
              div([
                p(classes: 'font-body-sm text-body-sm text-outline', [Component.text('تنبيهات المخزون')]),
                h3(classes: 'font-price-lg text-price-lg text-on-surface mt-1 font-bold', [
                  Component.text('$lowStockProducts'),
                ]),
                span(
                  classes: 'text-[11px] text-amber-600 font-semibold inline-flex items-center gap-0.5 mt-1',
                  [
                    span(classes: 'material-symbols-outlined text-[13px]', [Component.text('warning')]),
                    Component.text('تحتاج لإعادة طلب'),
                  ],
                ),
              ]),
              div(
                classes: 'w-12 h-12 rounded-xl bg-amber-50 text-amber-600 flex items-center justify-center shadow-sm',
                [
                  span(classes: 'material-symbols-outlined text-2xl', [Component.text('production_quantity_limits')]),
                ],
              ),
            ],
          ),
        ]),

        // Search & Filters Toolbar
        div(
          classes:
              'bg-surface-container-lowest p-4 rounded-2xl border border-surface-container-high/40 shadow-sm flex flex-wrap items-center justify-between gap-4',
          [
            div(classes: 'flex flex-wrap items-center gap-3 flex-1 min-w-[320px]', [
              // Search Input
              div(classes: 'relative flex-1 min-w-[240px]', [
                span(
                  classes:
                      'material-symbols-outlined absolute right-3.5 top-1/2 -translate-y-1/2 text-outline text-[18px]',
                  [Component.text('search')],
                ),
                input(
                  classes:
                      'w-full h-11 pr-10 pl-4 rounded-full border border-surface-container-high bg-surface-container-low/50 text-on-surface text-body-sm placeholder:text-outline focus:border-primary focus:bg-surface-container-lowest focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                  type: InputType.text,
                  attributes: {'placeholder': 'البحث بالاسم، كود SKU، أو الماركة...'},
                ),
              ]),

              // Category filter
              div(classes: 'relative', [
                select(
                  classes:
                      'h-11 pr-3 pl-8 rounded-full border border-surface-container-high bg-surface-container-low/50 text-on-surface text-body-sm focus:border-primary focus:ring-2 focus:ring-primary/20 appearance-none cursor-pointer',
                  [
                    option([Component.text('جميع الأقسام (الكل)')]),
                    for (final cat in (productsAsync.value?.map((p) => p.category).where((c) => c.isNotEmpty).toSet().toList() ?? ['أحذية وسنيكرز', 'إلكترونيات وسماعات', 'ملابس رجالية (cat_men)', 'قمصان رجالية (cat_men_shirts)']))
                      option([Component.text(cat)]),
                  ],
                ),
                span(
                  classes:
                      'material-symbols-outlined absolute left-2.5 top-1/2 -translate-y-1/2 text-outline pointer-events-none text-[18px]',
                  [Component.text('expand_more')],
                ),
              ]),
            ]),

            div(classes: 'flex items-center gap-2', [
              a(
                classes:
                    'h-11 px-4 rounded-full bg-primary text-on-primary hover:bg-primary-container text-body-sm font-bold flex items-center gap-1.5 shadow-sm transition-all',
                href: '/add-product',
                [
                  span(classes: 'material-symbols-outlined text-[18px]', [Component.text('add')]),
                  span([Component.text('منتج جديد')]),
                ],
              ),
            ]),
          ],
        ),

        // Products Table
        div(
          classes:
              'bg-surface-container-lowest rounded-2xl border border-surface-container-high/40 shadow-sm overflow-hidden',
          [
            div(classes: 'overflow-x-auto', [
              table(classes: 'w-full text-right border-collapse', [
                thead([
                  tr(classes: 'bg-surface-container-low/60 border-b border-surface-container-high/40 text-outline font-label-md text-label-md', [
                    th(classes: 'py-3.5 px-4 w-12 text-center', [
                      input(classes: 'rounded border-outline-variant text-primary focus:ring-primary', type: InputType.checkbox),
                    ]),
                    th(classes: 'py-3.5 px-4', [Component.text('المنتج والتفاصيل')]),
                    th(classes: 'py-3.5 px-4', [Component.text('القسم / التصنيف')]),
                    th(classes: 'py-3.5 px-4', [Component.text('السعر')]),
                    th(classes: 'py-3.5 px-4', [Component.text('حالة المخزون')]),
                    th(classes: 'py-3.5 px-4', [Component.text('المصدر / المصادقة')]),
                    th(classes: 'py-3.5 px-4 text-center', [Component.text('حالة النشر')]),
                    th(classes: 'py-3.5 px-4 text-center', [Component.text('الإجراءات')]),
                  ]),
                ]),
                tbody(classes: 'divide-y divide-surface-container-high/40 font-body-md text-body-md', [
                  // Loading state
                  if (productsAsync.isLoading && (productsAsync.value == null || productsAsync.value!.isEmpty))
                    tr([
                      td(
                        classes: 'py-16 text-center text-outline',
                        attributes: {'colspan': '8'},
                        [
                          div(classes: 'flex flex-col items-center justify-center gap-2', [
                            span(classes: 'material-symbols-outlined text-3xl text-primary animate-spin', [
                              Component.text('sync'),
                            ]),
                            p(classes: 'font-label-md text-label-md text-on-surface font-semibold', [
                              Component.text('جارٍ تحميل بيانات المنتجات من Firestore...'),
                            ]),
                          ]),
                        ],
                      ),
                    ])
                  // Error state
                  else if (productsAsync.hasError)
                    tr([
                      td(
                        classes: 'py-12 text-center text-error',
                        attributes: {'colspan': '8'},
                        [
                          div(classes: 'flex flex-col items-center justify-center gap-2', [
                            span(classes: 'material-symbols-outlined text-3xl', [Component.text('error')]),
                            p(classes: 'font-bold text-on-surface', [
                              Component.text('تعذر جلب المنتجات من قاعدة البيانات'),
                            ]),
                            p(classes: 'text-xs text-outline max-w-md', [
                              Component.text('${productsAsync.error}'),
                            ]),
                            button(
                              classes:
                                  'mt-2 px-4 py-1.5 rounded-full bg-primary text-on-primary text-xs font-bold cursor-pointer hover:bg-primary-container transition-all',
                              events: {'click': (e) => context.read(productsNotifierProvider.notifier).refresh()},
                              [Component.text('إعادة المحاولة')],
                            ),
                          ]),
                        ],
                      ),
                    ])
                  // Empty state
                  else if (productsAsync.value == null || productsAsync.value!.isEmpty)
                    tr([
                      td(
                        classes: 'py-16 text-center text-outline',
                        attributes: {'colspan': '8'},
                        [
                          div(classes: 'flex flex-col items-center justify-center gap-3', [
                            div(classes: 'w-14 h-14 rounded-2xl bg-surface-container flex items-center justify-center text-outline', [
                              span(classes: 'material-symbols-outlined text-3xl', [Component.text('inventory_2')]),
                            ]),
                            div([
                              p(classes: 'font-bold text-on-surface text-base', [
                                Component.text('لا توجد منتجات مسجلة في Firestore بعد'),
                              ]),
                              p(classes: 'text-xs text-outline mt-1', [
                                Component.text('ابدأ بإضافة أول منتج لمتجر نبض ليتمكن العميل من بدء العمل.'),
                              ]),
                            ]),
                            a(
                              classes:
                                  'mt-1 px-5 py-2 rounded-full bg-primary hover:bg-primary-container text-on-primary text-xs font-bold flex items-center gap-1.5 shadow-sm transition-all',
                              href: '/add-product',
                              [
                                span(classes: 'material-symbols-outlined text-base', [Component.text('add')]),
                                Component.text('إضافة أول منتج الآن'),
                              ],
                            ),
                          ]),
                        ],
                      ),
                    ])
                  // Live Dynamic Products (Static mock items completely eliminated)
                  else
                    for (final product in productsAsync.value!)
                      _buildProductRow(product),
                ]),
              ]),
            ]),
          ],
        ),
      ],
    );
  }

  static Component _buildProductRow(ProductModel product) {
    final stockLabel = product.isOutOfStock
        ? 'نفذت الكمية (0)'
        : (product.isLowStock
            ? 'منخفض (${product.stock} قطع فقط)'
            : 'متوفر (${product.stock} قطعة)');

    final stockColor = product.isOutOfStock
        ? 'red'
        : (product.isLowStock ? 'amber' : 'emerald');

    final stockPercent = product.isOutOfStock ? 0 : (product.isLowStock ? 20 : 85);

    final colorClasses = switch (stockColor) {
      'emerald' => ('bg-emerald-500', 'text-emerald-700'),
      'amber' => ('bg-secondary-container', 'text-secondary'),
      _ => ('bg-error', 'text-error'),
    };

    return tr(classes: 'hover:bg-surface-container-low/40 transition-colors', [
      td(classes: 'py-4 px-4 text-center', [
        input(classes: 'rounded border-outline-variant text-primary focus:ring-primary', type: InputType.checkbox),
      ]),
      td(classes: 'py-4 px-4', [
        div(classes: 'flex items-center gap-3', [
          img(
            classes: 'w-12 h-12 rounded-xl object-cover bg-surface-container border border-surface-container-high shrink-0',
            src: product.imageUrl,
            alt: product.displayName,
          ),
          div([
            div(classes: 'flex items-center gap-2', [
              a(classes: 'font-bold text-on-surface hover:text-primary transition-colors', href: '/add-product', [
                Component.text(product.displayName),
              ]),
              span(classes: 'bg-primary-fixed text-primary text-[10px] font-bold px-1.5 py-0.5 rounded-full', [
                Component.text('Firestore Live'),
              ]),
            ]),
            div(classes: 'flex items-center gap-2 mt-0.5', [
              span(classes: 'text-[11px] font-mono bg-surface-container px-1.5 py-0.5 rounded text-outline', [
                Component.text('SKU: ${product.sku}'),
              ]),
              span(classes: 'text-[11px] text-outline', [Component.text('الماركة: ${product.brand}')]),
            ]),
          ]),
        ]),
      ]),
      td(classes: 'py-4 px-4', [
        span(classes: 'bg-surface-container text-on-surface px-2.5 py-1 rounded-full text-xs font-medium', [
          Component.text(product.category),
        ]),
      ]),
      td(classes: 'py-4 px-4', [
        div(classes: 'font-price-sm text-price-sm text-on-surface font-bold', [
          Component.text('${product.effectivePrice} ر.س'),
        ]),
        if (product.discountPrice != null && product.discountPrice != product.price)
          div(classes: 'text-[11px] text-outline line-through', [
            Component.text('${product.price} ر.س'),
          ]),
      ]),
      td(classes: 'py-4 px-4', [
        div(classes: 'flex items-center gap-1.5', [
          span(classes: 'w-2 h-2 rounded-full ${colorClasses.$1}', []),
          span(classes: 'font-semibold ${colorClasses.$2}', [Component.text(stockLabel)]),
        ]),
        div(classes: 'w-24 bg-surface-container-high h-1.5 rounded-full mt-1.5 overflow-hidden', [
          div(classes: '${colorClasses.$1} h-full rounded-full', attributes: {'style': 'width: $stockPercent%'}, []),
        ]),
      ]),
      td(classes: 'py-4 px-4 font-semibold text-on-surface', [
        span(classes: 'text-xs text-primary font-bold flex items-center gap-1', [
          span(classes: 'material-symbols-outlined text-[14px]', [Component.text('cloud_done')]),
          Component.text(product.sales ?? 'Firestore Live'),
        ]),
      ]),
      td(classes: 'py-4 px-4 text-center', [
        label(classes: 'relative inline-flex items-center cursor-pointer', [
          input(classes: 'sr-only peer', type: InputType.checkbox, checked: product.isPublished),
          div(
            classes:
                'w-11 h-6 bg-outline-variant peer-focus:outline-none rounded-full peer peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[\'\'] after:absolute after:top-[2px] after:right-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary',
            [],
          ),
        ]),
      ]),
      td(classes: 'py-4 px-4 text-center', [
        div(classes: 'flex items-center justify-center gap-1 text-outline', [
          a(
            classes: 'p-1.5 rounded-lg hover:bg-surface-container hover:text-primary transition-colors',
            href: '/add-product',
            attributes: {'title': 'تعديل المنتج'},
            [span(classes: 'material-symbols-outlined text-[18px]', [Component.text('edit')])],
          ),
          button(
            classes: 'p-1.5 rounded-lg hover:bg-surface-container hover:text-primary transition-colors',
            attributes: {'title': 'معاينة في المتجر'},
            [span(classes: 'material-symbols-outlined text-[18px]', [Component.text('visibility')])],
          ),
          button(
            classes: 'p-1.5 rounded-lg hover:bg-error-container hover:text-error transition-colors',
            attributes: {'title': 'حذف'},
            [span(classes: 'material-symbols-outlined text-[18px]', [Component.text('delete')])],
          ),
        ]),
      ]),
    ]);
  }
}
