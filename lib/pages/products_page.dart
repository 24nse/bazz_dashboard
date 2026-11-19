import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import '../services/firebase_service.dart';

/// The Products & Inventory Management Page in Jaspr for Matjar Nabdh.
/// Supports live fetching from Firebase Firestore for project 'lipsk'.
class ProductsPage extends StatefulComponent {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Map<String, dynamic>> firebaseProducts = [];
  bool isLoading = false;
  String? loadError;

  @override
  void initState() {
    super.initState();
    _fetchFirebaseProducts();
  }

  Future<void> _fetchFirebaseProducts() async {
    setState(() {
      isLoading = true;
      loadError = null;
    });

    try {
      final items = await FirebaseService.getProducts();
      setState(() {
        firebaseProducts = items;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        loadError = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Component build(BuildContext context) {
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
              events: {'click': (e) => _fetchFirebaseProducts()},
              [
                span(classes: 'material-symbols-outlined text-[18px] ${isLoading ? "animate-spin" : ""}', [
                  Component.text('sync'),
                ]),
                span([Component.text(isLoading ? 'جارٍ المزامنة...' : 'مزامنة مع Firebase lipsak')]),
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

        // KPI Summary Cards (4 Cards)
        div(classes: 'grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4', [
          // Total Products
          div(
            classes:
                'bg-surface-container-lowest p-5 rounded-2xl border border-surface-container-high/40 shadow-sm flex items-center justify-between',
            [
              div([
                p(classes: 'font-body-sm text-body-sm text-outline', [Component.text('إجمالي المنتجات')]),
                h3(classes: 'font-price-lg text-price-lg text-on-surface mt-1 font-bold', [
                  Component.text('${340 + firebaseProducts.length}'),
                ]),
                span(
                  classes: 'text-[11px] text-emerald-600 font-semibold inline-flex items-center gap-0.5 mt-1',
                  [
                    span(classes: 'material-symbols-outlined text-[13px]', [Component.text('trending_up')]),
                    Component.text('+${firebaseProducts.length} من Firebase'),
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
                  Component.text('${312 + firebaseProducts.where((p) => p['isPublished'] == true).length}'),
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

          // Firebase Live Count
          div(
            classes:
                'bg-surface-container-lowest p-5 rounded-2xl border-2 border-primary/30 shadow-sm flex items-center justify-between',
            [
              div([
                p(classes: 'font-body-sm text-body-sm text-primary font-bold', [Component.text('مستندات Firebase lipsak')]),
                h3(classes: 'font-price-lg text-price-lg text-primary mt-1 font-bold', [
                  Component.text('${firebaseProducts.length}'),
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
                h3(classes: 'font-price-lg text-price-lg text-on-surface mt-1 font-bold', [Component.text('18')]),
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
                    option([Component.text('أحذية وسنيكرز')]),
                    option([Component.text('إلكترونيات وسماعات')]),
                    option([Component.text('ملابس رياضية')]),
                    option([Component.text('إكسسوارات وساعات')]),
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
                  // Dynamically render Firebase products first
                  for (final fbProd in firebaseProducts)
                    _buildProductRow(
                      imageUrl: fbProd['imageUrl']?.toString() ??
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuDWnaA1xderq1MlEPMwI9HNmHkmJW71LkSgseqGGboAEwdE-_wFaxzVPNtGUB0QMWakdritPZ4b9eKQqA1cCr74EHpJmdNws0zBmoOP8nW7v-5yulYG5WO_LunNrqSZYW8FOA45E2nfPjXvtp4eggUysjR5AmC2AJUMRmNjFdl5wv_4GZqk7a1pVxaDuTbhNcIbELLqAnTcIhTqzGQxdkAbjd6r0egLM0bN_8IgjpT_3c_BkTYczcaY',
                      title: fbProd['nameAr']?.toString().isNotEmpty == true
                          ? fbProd['nameAr'].toString()
                          : (fbProd['nameEn']?.toString() ?? 'منتج بدون اسم'),
                      sku: fbProd['sku']?.toString() ?? 'N/A',
                      brand: fbProd['brand']?.toString() ?? 'متجر نبض',
                      category: fbProd['category']?.toString() ?? 'عام',
                      price: '${fbProd['discountPrice'] ?? fbProd['price'] ?? 0} ر.س',
                      oldPrice: (fbProd['discountPrice'] != null && fbProd['discountPrice'] != fbProd['price'])
                          ? '${fbProd['price']} ر.س'
                          : null,
                      stockLabel: 'متوفر (${fbProd['stock'] ?? 0} قطعة)',
                      stockColor: (fbProd['stock'] is num && (fbProd['stock'] as num) > 10) ? 'emerald' : 'amber',
                      stockPercent: 90,
                      sales: 'Firebase Live (lipsak)',
                      isPublished: fbProd['isPublished'] == true,
                      isFromFirebase: true,
                    ),

                  // Default Catalog Row 1
                  _buildProductRow(
                    imageUrl:
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuDWnaA1xderq1MlEPMwI9HNmHkmJW71LkSgseqGGboAEwdE-_wFaxzVPNtGUB0QMWakdritPZ4b9eKQqA1cCr74EHpJmdNws0zBmoOP8nW7v-5yulYG5WO_LunNrqSZYW8FOA45E2nfPjXvtp4eggUysjR5AmC2AJUMRmNjFdl5wv_4GZqk7a1pVxaDuTbhNcIbELLqAnTcIhTqzGQxdkAbjd6r0egLM0bN_8IgjpT_3c_BkTYczcaY',
                    title: 'حذاء نايكي إير ماكس بلس 2025',
                    sku: 'NKE-AMX-2025',
                    brand: 'Nike',
                    category: 'أحذية وسنيكرز',
                    price: '479 ر.س',
                    oldPrice: '549 ر.س',
                    stockLabel: 'متوفر (184 قطعة)',
                    stockColor: 'emerald',
                    stockPercent: 78,
                    sales: '1,420 طلب',
                    isPublished: true,
                  ),

                  // Row 2
                  _buildProductRow(
                    imageUrl:
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuC5CMnDlEAQrBv-yXbVZvmdpiZxUrRZUmAbjbejN9sQTGc1iVexleJsCtQ1EMJQ39KEK37zVu7E1ieYKy9nnRD4ckY3lNIJ0flUoMxRGZ0Mzu2Y9gC4moex69NTMOb2jGxmvi8XlW-eNjtcjFgCP5LLqS8YLa5P7hLf3tGE0I6BhbrXfaTMS9LUOv5jXQGwEZ7fGtArbsYUZd2n9UQlPZ2hkzC5lROx24SaNNh1A94o185rdLdC8UlW',
                    title: 'سماعة سوني اللاسلكية WH-1000XM5',
                    sku: 'SNY-XM5-BLK',
                    brand: 'Sony',
                    category: 'إلكترونيات وسماعات',
                    price: '1,199 ر.س',
                    oldPrice: '1,399 ر.س',
                    stockLabel: 'منخفض (6 قطع فقط)',
                    stockColor: 'amber',
                    stockPercent: 15,
                    sales: '850 طلب',
                    isPublished: true,
                  ),

                  // Row 3
                  _buildProductRow(
                    imageUrl:
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuBSFyeMkoRDE-ByDpjFQYysy-9itHRu7IH99GSvuL1nRJVSzOsh0-GoCK6F_iOJ5zrXbjAFQONgrDqoDjRRlrVyZv6nCT1AnMQ9bCHDg2mPeE_b9h2abQaqr7Q92jcq8MDangw95cmmWklbCitGIJS2qyrPUqFmNPiwgON72086LBoYveOy-PKGLD7_fMc8uWx3C1wgxjmg8JcdbpuhFeiowyvSpDSuMfp4Cs185CXiJeaCzFwalQr6',
                    title: 'ساعة آبل الذكية الجيل التاسع GPS',
                    sku: 'APL-W9-45MM',
                    brand: 'Apple',
                    category: 'إكسسوارات وساعات',
                    price: '1,799 ر.س',
                    oldPrice: null,
                    stockLabel: 'نفذت الكمية (0)',
                    stockColor: 'red',
                    stockPercent: 0,
                    sales: '2,105 طلب',
                    isPublished: false,
                  ),
                ]),
              ]),
            ]),
          ],
        ),
      ],
    );
  }

  static Component _buildProductRow({
    required String imageUrl,
    required String title,
    required String sku,
    required String brand,
    required String category,
    required String price,
    String? oldPrice,
    required String stockLabel,
    required String stockColor,
    required int stockPercent,
    required String sales,
    required bool isPublished,
    bool isFromFirebase = false,
  }) {
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
            src: imageUrl,
            alt: title,
          ),
          div([
            div(classes: 'flex items-center gap-2', [
              a(classes: 'font-bold text-on-surface hover:text-primary transition-colors', href: '/add-product', [
                Component.text(title),
              ]),
              if (isFromFirebase)
                span(classes: 'bg-primary-fixed text-primary text-[10px] font-bold px-1.5 py-0.5 rounded-full', [
                  Component.text('Firebase lipsk'),
                ]),
            ]),
            div(classes: 'flex items-center gap-2 mt-0.5', [
              span(classes: 'text-[11px] font-mono bg-surface-container px-1.5 py-0.5 rounded text-outline', [
                Component.text('SKU: $sku'),
              ]),
              span(classes: 'text-[11px] text-outline', [Component.text('الماركة: $brand')]),
            ]),
          ]),
        ]),
      ]),
      td(classes: 'py-4 px-4', [
        span(classes: 'bg-surface-container text-on-surface px-2.5 py-1 rounded-full text-xs font-medium', [
          Component.text(category),
        ]),
      ]),
      td(classes: 'py-4 px-4', [
        div(classes: 'font-price-sm text-price-sm text-on-surface font-bold', [Component.text(price)]),
        if (oldPrice != null)
          div(classes: 'text-[11px] text-outline line-through', [Component.text(oldPrice)]),
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
        if (isFromFirebase)
          span(classes: 'text-xs text-primary font-bold flex items-center gap-1', [
            span(classes: 'material-symbols-outlined text-[14px]', [Component.text('cloud_done')]),
            Component.text('Firestore Live'),
          ])
        else
          Component.text(sales),
      ]),
      td(classes: 'py-4 px-4 text-center', [
        label(classes: 'relative inline-flex items-center cursor-pointer', [
          input(classes: 'sr-only peer', type: InputType.checkbox, checked: isPublished),
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
