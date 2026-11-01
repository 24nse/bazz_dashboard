import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// The Add Product Page in Jaspr for Matjar Nabdh Admin Dashboard.
/// Implements a rich, RTL Arabic UI matching the Stitch design system.
class AddProductPage extends StatefulComponent {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  // Form state
  String nameAr = 'حذاء نايكي إير ماكس بلس 2025';
  String nameEn = 'Nike Air Max Plus 2025 Athletic Sneakers';
  String sku = 'NKE-AMX-2025';
  String barcode = '628100923847';
  String category = 'أحذية وسنيكرز';
  String brand = 'Nike';
  String price = '549';
  String discountPrice = '479';
  String stock = '42';
  String lowStockThreshold = '5';
  bool isTaxIncluded = true;
  bool isPublished = true;
  bool isSaved = false;

  final List<String> sizes = ['40', '41', '42', '43', '44'];
  final List<String> selectedSizes = ['40', '41', '42', '43'];
  final List<Map<String, String>> colors = [
    {'name': 'أسود', 'bg': 'bg-black', 'ring': 'ring-black'},
    {'name': 'أبيض', 'bg': 'bg-white', 'ring': 'ring-gray-300'},
    {'name': 'أزرق ملكي', 'bg': 'bg-blue-600', 'ring': 'ring-blue-600'},
    {'name': 'أحمر قرمزي', 'bg': 'bg-red-600', 'ring': 'ring-red-600'},
  ];
  String selectedColor = 'أسود';

  void _saveProduct() {
    setState(() {
      isSaved = true;
    });
  }

  @override
  Component build(BuildContext context) {
    return main_(
      classes: 'flex-1 overflow-y-auto custom-scroll p-space-xl space-y-space-xl',
      [
        // Top Breadcrumb & Actions Bar
        div(classes: 'flex flex-wrap items-center justify-between gap-4 pb-2 border-b border-surface-container-high/40', [
          div(classes: 'flex flex-col gap-1', [
            // Breadcrumbs
            div(classes: 'flex items-center gap-2 text-outline text-body-sm font-label-md', [
              a(
                classes: 'hover:text-primary transition-colors flex items-center gap-1',
                href: '/',
                [
                  span(classes: 'material-symbols-outlined text-[16px]', [Component.text('home')]),
                  Component.text('الرئيسية'),
                ],
              ),
              span(classes: 'material-symbols-outlined text-[14px]', [Component.text('chevron_left')]),
              a(
                classes: 'hover:text-primary transition-colors',
                href: '/products',
                [Component.text('المنتجات والمخزون')],
              ),
              span(classes: 'material-symbols-outlined text-[14px]', [Component.text('chevron_left')]),
              span(classes: 'text-primary font-bold', [Component.text('إضافة منتج جديد')]),
            ]),
            h1(classes: 'font-headline-md text-headline-md font-bold text-on-surface flex items-center gap-2.5', [
              div(classes: 'w-9 h-9 rounded-xl bg-primary-fixed text-primary flex items-center justify-center', [
                span(classes: 'material-symbols-outlined text-[22px]', [Component.text('add_box')]),
              ]),
              Component.text('إضافة منتج جديد للمتجر'),
            ]),
          ]),

          // Top Action Buttons
          div(classes: 'flex items-center gap-3', [
            a(
              classes:
                  'px-4 py-2 rounded-full border border-surface-container-high bg-surface-container-lowest hover:bg-surface-container text-on-surface font-label-md text-label-md transition-all flex items-center gap-2',
              href: '/products',
              [
                span(classes: 'material-symbols-outlined text-[18px]', [Component.text('arrow_forward')]),
                Component.text('العودة للمنتجات'),
              ],
            ),
            button(
              classes:
                  'px-4 py-2 rounded-full border border-surface-container-high bg-surface-container-lowest hover:bg-surface-container text-on-surface font-label-md text-label-md transition-all flex items-center gap-2',
              events: {'click': (e) => _saveProduct()},
              [
                span(classes: 'material-symbols-outlined text-[18px]', [Component.text('drafts')]),
                Component.text('حفظ كمسودة'),
              ],
            ),
            button(
              classes:
                  'px-6 py-2 rounded-full bg-primary hover:bg-primary-container text-on-primary font-label-md text-label-md font-bold shadow-md shadow-primary/20 active:scale-95 transition-all flex items-center gap-2',
              events: {'click': (e) => _saveProduct()},
              [
                span(classes: 'material-symbols-outlined text-[20px]', [Component.text('cloud_done')]),
                Component.text('حفظ ونشر في المتجر'),
              ],
            ),
          ]),
        ]),

        // Notification banner if saved
        if (isSaved)
          div(
            classes:
                'p-4 bg-emerald-50 border border-emerald-200 rounded-2xl flex items-center justify-between text-emerald-800 shadow-sm animate-fade-in',
            [
              div(classes: 'flex items-center gap-3', [
                span(classes: 'material-symbols-outlined text-emerald-600 text-2xl', [Component.text('check_circle')]),
                div([
                  p(classes: 'font-bold font-label-md', [Component.text('تم حفظ وتحديث بيانات المنتج بنجاح!')]),
                  p(classes: 'text-xs text-emerald-700', [
                    Component.text('تمت المزامنة اللحظية مع Firebase Firestore وتطبيق المتجر (Flutter App).'),
                  ]),
                ]),
              ]),
              button(
                classes: 'text-emerald-700 hover:text-emerald-900',
                events: {'click': (e) => setState(() => isSaved = false)},
                [span(classes: 'material-symbols-outlined text-[20px]', [Component.text('close')])],
              ),
            ],
          ),

        // Main Two-Column Layout (Form Body)
        div(classes: 'grid grid-cols-1 lg:grid-cols-3 gap-space-xl items-start', [
          // Left Column (Wide, 2/3): Main Content & Media
          div(classes: 'lg:col-span-2 space-y-space-xl', [
            // 1. Media & Images Upload Box
            div(
              classes:
                  'bg-surface-container-lowest p-space-lg rounded-2xl border border-surface-container-high/40 shadow-sm space-y-4',
              [
                div(classes: 'flex items-center justify-between', [
                  div(classes: 'flex items-center gap-2', [
                    span(classes: 'material-symbols-outlined text-primary text-[22px]', [Component.text('photo_library')]),
                    h2(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface', [
                      Component.text('صور ووسائط المنتج'),
                    ]),
                  ]),
                  span(classes: 'text-xs bg-primary-fixed/60 text-primary font-bold px-2 py-0.5 rounded-full', [
                    Component.text('Firebase Storage'),
                  ]),
                ]),

                // Dropzone Box
                div(
                  classes:
                      'border-2 border-dashed border-outline-variant/60 hover:border-primary rounded-2xl p-8 text-center bg-surface-container-low/40 transition-all cursor-pointer group',
                  [
                    div(
                      classes:
                          'w-14 h-14 mx-auto rounded-full bg-surface-container flex items-center justify-center text-primary group-hover:scale-110 transition-transform shadow-sm',
                      [
                        span(classes: 'material-symbols-outlined text-3xl', [Component.text('cloud_upload')]),
                      ],
                    ),
                    p(classes: 'font-label-md text-label-md text-on-surface mt-3 font-bold', [
                      Component.text('اسحب وأفلت الصور هنا أو انقر للتصفح'),
                    ]),
                    p(classes: 'text-xs text-outline mt-1', [
                      Component.text('يدعم صيغ PNG, JPG, WEBP حتى 5 ميجابايت (النسبة 1:1 مربعة هي الأفضل)'),
                    ]),
                  ],
                ),

                // Thumbnails Gallery
                div(classes: 'flex flex-wrap items-center gap-3 pt-1', [
                  // Image 1 (Main)
                  div(
                    classes:
                        'relative w-24 h-24 rounded-2xl overflow-hidden border-2 border-primary group shadow-sm bg-surface-container',
                    [
                      img(
                        classes: 'w-full h-full object-cover',
                        src:
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuDWnaA1xderq1MlEPMwI9HNmHkmJW71LkSgseqGGboAEwdE-_wFaxzVPNtGUB0QMWakdritPZ4b9eKQqA1cCr74EHpJmdNws0zBmoOP8nW7v-5yulYG5WO_LunNrqSZYW8FOA45E2nfPjXvtp4eggUysjR5AmC2AJUMRmNjFdl5wv_4GZqk7a1pVxaDuTbhNcIbELLqAnTcIhTqzGQxdkAbjd6r0egLM0bN_8IgjpT_3c_BkTYczcaY',
                        alt: 'صورة المنتج الرئيسية',
                      ),
                      span(
                        classes:
                            'absolute top-1.5 right-1.5 bg-primary text-on-primary text-[10px] px-1.5 py-0.5 rounded-full font-bold shadow-sm',
                        [Component.text('الرئيسية')],
                      ),
                      button(
                        classes:
                            'absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 flex items-center justify-center text-white transition-opacity',
                        [span(classes: 'material-symbols-outlined text-[20px]', [Component.text('visibility')])],
                      ),
                    ],
                  ),

                  // Image 2
                  div(
                    classes:
                        'relative w-24 h-24 rounded-2xl overflow-hidden border border-surface-container-high group shadow-sm bg-surface-container',
                    [
                      img(
                        classes: 'w-full h-full object-cover',
                        src:
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuDfWZApkeWMtL_zEE0S285oPFDtkWi1J2sMz7v5nAszXwjjmfKQZfp3i2u3OMt832StxkfvQJyjELVDFO5OnuAd7x8hKUWTdaZGvkasm_hIhR72g3NtRJ9UhWb8vLiTczwASTTJzgu0Bj4DYVQYLOYe6vK6_v3vLlx3UgZ6A9r2Ki1F4xavlbT8cGQZL5YdgtoR144i8d-rYQjy2AZsHmHdR1RF1AFGUtbdtk4aGQUzYrsplKvG_S5R',
                        alt: 'زاوية ثانية للمنتج',
                      ),
                      button(
                        classes:
                            'absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 flex items-center justify-center text-white transition-opacity',
                        [span(classes: 'material-symbols-outlined text-[20px]', [Component.text('delete')])],
                      ),
                    ],
                  ),

                  // Image 3
                  div(
                    classes:
                        'relative w-24 h-24 rounded-2xl overflow-hidden border border-surface-container-high group shadow-sm bg-surface-container',
                    [
                      img(
                        classes: 'w-full h-full object-cover',
                        src:
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuDeQcu-i0GzUyloM3ENmOb-oKjshvJveqM0qReOQYDZma-Ei66ODJ3VVsWYecsyNV8-icbKMpNJvQ7XHsonFq86SBfc9_gf4h0KGE4aVyOcp_pbMfYgEtetUFOiTGRylxujJk8iFq0W42XFiZdZJDXuAMbxMRBIdjFuOXtbp-KRKw0As_v8SH8NWKn3UdiiCfMqxvbFxYYz5qdRaK_FSL8P5JXDKxba-jVsVtyz2xmBOkVHpye8BSYL',
                        alt: 'صورة نعل الحذاء',
                      ),
                      button(
                        classes:
                            'absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 flex items-center justify-center text-white transition-opacity',
                        [span(classes: 'material-symbols-outlined text-[20px]', [Component.text('delete')])],
                      ),
                    ],
                  ),

                  // Add Image Trigger Button
                  button(
                    classes:
                        'w-24 h-24 rounded-2xl border-2 border-dashed border-surface-container-high hover:border-primary flex flex-col items-center justify-center text-outline hover:text-primary transition-colors bg-surface-container-low/30',
                    [
                      span(classes: 'material-symbols-outlined text-[24px]', [Component.text('add_photo_alternate')]),
                      span(classes: 'text-[11px] font-bold mt-1', [Component.text('إضافة صورة')]),
                    ],
                  ),
                ]),
              ],
            ),

            // 2. Basic Information Form Card
            div(
              classes:
                  'bg-surface-container-lowest p-space-lg rounded-2xl border border-surface-container-high/40 shadow-sm space-y-4',
              [
                div(classes: 'flex items-center gap-2 pb-2 border-b border-surface-container-high/30', [
                  span(classes: 'material-symbols-outlined text-primary text-[22px]', [Component.text('edit_note')]),
                  h2(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface', [
                    Component.text('البيانات الأساسية للمنتج'),
                  ]),
                ]),

                div(classes: 'space-y-4', [
                  // Name AR
                  div([
                    label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                      Component.text('اسم المنتج باللغة العربية *'),
                    ]),
                    input(
                      classes:
                          'w-full h-11 px-4 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-body-md focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                      type: InputType.text,
                      value: nameAr,
                      attributes: {'placeholder': 'أدخل اسم المنتج باللغة العربية'},
                    ),
                  ]),

                  // Name EN
                  div([
                    label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                      Component.text('اسم المنتج باللغة الإنجليزية (Product Name EN)'),
                    ]),
                    input(
                      classes:
                          'w-full h-11 px-4 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-body-md text-left focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                      type: InputType.text,
                      value: nameEn,
                      attributes: {'dir': 'ltr', 'placeholder': 'e.g. Nike Air Max Plus 2025 Athletic Sneakers'},
                    ),
                  ]),

                  // SKU & Barcode Grid
                  div(classes: 'grid grid-cols-1 md:grid-cols-2 gap-4', [
                    div([
                      label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                        Component.text('رمز التخزين التعريفي (SKU) *'),
                      ]),
                      div(classes: 'relative', [
                        input(
                          classes:
                              'w-full h-11 px-4 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-mono text-sm focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                          type: InputType.text,
                          value: sku,
                          attributes: {'dir': 'ltr', 'placeholder': 'NKE-AMX-2025'},
                        ),
                        span(
                          classes:
                              'material-symbols-outlined absolute right-3.5 top-1/2 -translate-y-1/2 text-outline text-[18px]',
                          [Component.text('tag')],
                        ),
                      ]),
                    ]),

                    div([
                      label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                        Component.text('الباركود الدولي (Barcode / UPC)'),
                      ]),
                      div(classes: 'relative', [
                        input(
                          classes:
                              'w-full h-11 px-4 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-mono text-sm focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                          type: InputType.text,
                          value: barcode,
                          attributes: {'dir': 'ltr', 'placeholder': '628100923847'},
                        ),
                        span(
                          classes:
                              'material-symbols-outlined absolute right-3.5 top-1/2 -translate-y-1/2 text-outline text-[18px]',
                          [Component.text('barcode_scanner')],
                        ),
                      ]),
                    ]),
                  ]),

                  // Description
                  div([
                    label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                      Component.text('الوصف التفصيلي للمنتج ومميزاته'),
                    ]),
                    textarea(
                      classes:
                          'w-full p-3.5 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-body-md focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                      attributes: {
                        'rows': '4',
                        'placeholder': 'اكتب وصفاً جذاباً يشمل تفاصيل الخامة، مميزات الاستخدام، وملاحظات المقاس...',
                      },
                      [
                        Component.text(
                          'حذاء رياضي متطور مزود بتقنية الوسائد الهوائية الثورية من نايكي لتوفير أقصى درجات الراحة والمرونة أثناء الجري والتمارين اليومية مع نعل متين مقاوم للانزلاق.',
                        ),
                      ],
                    ),
                  ]),
                ]),
              ],
            ),

            // 3. Pricing & Discounts Form Card
            div(
              classes:
                  'bg-surface-container-lowest p-space-lg rounded-2xl border border-surface-container-high/40 shadow-sm space-y-4',
              [
                div(classes: 'flex items-center gap-2 pb-2 border-b border-surface-container-high/30', [
                  span(classes: 'material-symbols-outlined text-primary text-[22px]', [Component.text('payments')]),
                  h2(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface', [
                    Component.text('التسعير والعروض الترويجية'),
                  ]),
                ]),

                div(classes: 'grid grid-cols-1 md:grid-cols-2 gap-4', [
                  // Base Price
                  div([
                    label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                      Component.text('السعر الأساسي الأصلي *'),
                    ]),
                    div(classes: 'relative', [
                      input(
                        classes:
                            'w-full h-11 pr-4 pl-14 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-price-sm text-price-sm focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                        type: InputType.number,
                        value: price,
                        attributes: {'placeholder': '549'},
                      ),
                      span(
                        classes:
                            'absolute left-3.5 top-1/2 -translate-y-1/2 text-xs font-bold text-outline bg-surface-container px-2 py-0.5 rounded-md',
                        [Component.text('ر.س')],
                      ),
                    ]),
                  ]),

                  // Discount Price
                  div([
                    label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                      Component.text('سعر التخفيض (الترويجي في التطبيق)'),
                    ]),
                    div(classes: 'relative', [
                      input(
                        classes:
                            'w-full h-11 pr-4 pl-14 rounded-xl border border-outline-variant/60 bg-surface text-emerald-700 font-price-sm text-price-sm font-bold focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                        type: InputType.number,
                        value: discountPrice,
                        attributes: {'placeholder': '479'},
                      ),
                      span(
                        classes:
                            'absolute left-3.5 top-1/2 -translate-y-1/2 text-xs font-bold text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded-md',
                        [Component.text('ر.س')],
                      ),
                    ]),
                  ]),
                ]),

                // VAT checkbox toggle card
                div(
                  classes:
                      'flex items-center justify-between p-4 rounded-xl bg-surface-container-low/60 border border-surface-container-high/60',
                  [
                    div([
                      p(classes: 'font-label-md text-label-md font-bold text-on-surface', [
                        Component.text('احتساب ضريبة القيمة المضافة (15% VAT)'),
                      ]),
                      p(classes: 'text-xs text-outline mt-0.5', [
                        Component.text('السعر المعروض للعملاء في متجر نبض يشمل ضريبة القيمة المضافة طبقاً للأنظمة.'),
                      ]),
                    ]),
                    input(
                      classes: 'w-5 h-5 rounded text-primary focus:ring-primary cursor-pointer',
                      type: InputType.checkbox,
                      checked: isTaxIncluded,
                    ),
                  ],
                ),
              ],
            ),

            // 4. Variants: Sizes & Colors
            div(
              classes:
                  'bg-surface-container-lowest p-space-lg rounded-2xl border border-surface-container-high/40 shadow-sm space-y-4',
              [
                div(classes: 'flex items-center gap-2 pb-2 border-b border-surface-container-high/30', [
                  span(classes: 'material-symbols-outlined text-primary text-[22px]', [Component.text('tune')]),
                  h2(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface', [
                    Component.text('المتغيرات والخيارات (المقاسات والألوان)'),
                  ]),
                ]),

                // Sizes
                div(classes: 'space-y-2', [
                  label(classes: 'block font-label-md text-label-md font-semibold text-on-surface', [
                    Component.text('المقاسات المتاحة لهذا المنتج'),
                  ]),
                  div(classes: 'flex flex-wrap items-center gap-2', [
                    for (final s in sizes)
                      span(
                        classes:
                            'h-10 px-4 rounded-xl ${selectedSizes.contains(s) ? "bg-primary text-on-primary font-bold shadow-sm" : "bg-surface-container text-on-surface border border-surface-container-high"} text-xs flex items-center gap-2 cursor-pointer transition-all',
                        [
                          Component.text(s),
                          span(classes: 'material-symbols-outlined text-[14px] hover:opacity-75', [Component.text('close')]),
                        ],
                      ),
                    button(
                      classes:
                          'h-10 px-4 rounded-xl border border-dashed border-primary text-primary hover:bg-primary/5 text-xs font-bold flex items-center gap-1.5 transition-colors',
                      [
                        span(classes: 'material-symbols-outlined text-[16px]', [Component.text('add')]),
                        Component.text('إضافة مقاس جديد'),
                      ],
                    ),
                  ]),
                ]),

                // Colors
                div(classes: 'space-y-2 pt-2', [
                  label(classes: 'block font-label-md text-label-md font-semibold text-on-surface', [
                    Component.text('الألوان المتوفرة'),
                  ]),
                  div(classes: 'flex items-center gap-3', [
                    for (final c in colors)
                      div(
                        classes:
                            'w-9 h-9 rounded-full ${c['bg']} ${selectedColor == c['name'] ? "ring-2 ring-primary ring-offset-2 scale-110" : "border border-outline-variant/60"} cursor-pointer flex items-center justify-center transition-all shadow-sm',
                        attributes: {'title': c['name']!},
                        [
                          if (selectedColor == c['name'])
                            span(
                              classes:
                                  'material-symbols-outlined text-[18px] ${c['name'] == 'أبيض' ? 'text-black' : 'text-white'}',
                              [Component.text('check')],
                            ),
                        ],
                      ),
                    button(
                      classes:
                          'w-9 h-9 rounded-full border border-dashed border-outline-variant hover:border-primary flex items-center justify-center text-outline hover:text-primary transition-colors',
                      attributes: {'title': 'إضافة لون جديد'},
                      [
                        span(classes: 'material-symbols-outlined text-[18px]', [Component.text('add')]),
                      ],
                    ),
                  ]),
                ]),
              ],
            ),
          ]),

          // Right Column (Sidebar style, 1/3): Status, Category & Inventory
          div(classes: 'space-y-space-xl', [
            // 1. Publishing & Visibility Card
            div(
              classes:
                  'bg-surface-container-lowest p-space-lg rounded-2xl border border-surface-container-high/40 shadow-sm space-y-4',
              [
                h3(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface flex items-center gap-2', [
                  span(classes: 'material-symbols-outlined text-primary text-[20px]', [Component.text('visibility')]),
                  Component.text('حالة النشر والظهور'),
                ]),

                div(
                  classes:
                      'p-3.5 rounded-xl bg-surface-container-low/60 border border-surface-container-high/60 flex items-center justify-between',
                  [
                    div([
                      p(classes: 'font-label-md text-label-md font-bold text-on-surface', [
                        Component.text('نشر المنتج بالمتجر'),
                      ]),
                      p(classes: 'text-xs text-outline mt-0.5', [
                        Component.text('متاح للطلب الفوري في التطبيق'),
                      ]),
                    ]),
                    label(classes: 'relative inline-flex items-center cursor-pointer', [
                      input(
                        classes: 'sr-only peer',
                        type: InputType.checkbox,
                        checked: isPublished,
                      ),
                      div(
                        classes:
                            'w-11 h-6 bg-outline-variant peer-focus:outline-none rounded-full peer peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[\'\'] after:absolute after:top-[2px] after:right-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary',
                        [],
                      ),
                    ]),
                  ],
                ),

                div(classes: 'flex items-center justify-between text-xs py-2 border-t border-surface-container-high/40', [
                  span(classes: 'text-outline', [Component.text('حالة المنتج: ')]),
                  span(
                    classes:
                        'bg-emerald-50 text-emerald-700 font-bold px-2.5 py-1 rounded-full flex items-center gap-1',
                    [
                      span(classes: 'w-2 h-2 rounded-full bg-emerald-500 animate-pulse', []),
                      Component.text('نشط ومتاح للعملاء'),
                    ],
                  ),
                ]),
              ],
            ),

            // 2. Category & Brand Card
            div(
              classes:
                  'bg-surface-container-lowest p-space-lg rounded-2xl border border-surface-container-high/40 shadow-sm space-y-4',
              [
                h3(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface flex items-center gap-2', [
                  span(classes: 'material-symbols-outlined text-primary text-[20px]', [Component.text('category')]),
                  Component.text('التصنيف والماركة'),
                ]),

                // Category Select
                div([
                  label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                    Component.text('القسم الرئيسي بالمتجر *'),
                  ]),
                  div(classes: 'relative', [
                    select(
                      classes:
                          'w-full h-11 pr-3 pl-9 rounded-xl border border-outline-variant/60 bg-surface text-on-surface text-body-md focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none cursor-pointer appearance-none',
                      [
                        option(value: 'أحذية وسنيكرز', selected: true, [Component.text('أحذية وسنيكرز')]),
                        option(value: 'إلكترونيات وسماعات', [Component.text('إلكترونيات وسماعات')]),
                        option(value: 'ملابس رياضية', [Component.text('ملابس رياضية')]),
                        option(value: 'إكسسوارات وساعات', [Component.text('إكسسوارات وساعات')]),
                      ],
                    ),
                    span(
                      classes:
                          'material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-outline pointer-events-none text-[20px]',
                      [Component.text('expand_more')],
                    ),
                  ]),
                ]),

                // Brand Select
                div([
                  label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                    Component.text('الماركة التجارية (Brand)'),
                  ]),
                  div(classes: 'relative', [
                    select(
                      classes:
                          'w-full h-11 pr-3 pl-9 rounded-xl border border-outline-variant/60 bg-surface text-on-surface text-body-md focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none cursor-pointer appearance-none',
                      [
                        option(value: 'Nike', selected: true, [Component.text('Nike')]),
                        option(value: 'Adidas', [Component.text('Adidas')]),
                        option(value: 'Sony', [Component.text('Sony')]),
                        option(value: 'Apple', [Component.text('Apple')]),
                        option(value: 'Puma', [Component.text('Puma')]),
                      ],
                    ),
                    span(
                      classes:
                          'material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-outline pointer-events-none text-[20px]',
                      [Component.text('expand_more')],
                    ),
                  ]),
                ]),

                // Tags
                div([
                  label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                    Component.text('العلامات والوسوم (Tags)'),
                  ]),
                  div(classes: 'flex flex-wrap gap-1.5', [
                    span(
                      classes: 'bg-surface-container text-on-surface px-2.5 py-1 rounded-full text-xs font-semibold',
                      [Component.text('#رياضي')],
                    ),
                    span(
                      classes: 'bg-surface-container text-on-surface px-2.5 py-1 rounded-full text-xs font-semibold',
                      [Component.text('#جديد_2025')],
                    ),
                    span(
                      classes: 'bg-surface-container text-on-surface px-2.5 py-1 rounded-full text-xs font-semibold',
                      [Component.text('#الأكثر_طلباً')],
                    ),
                    button(
                      classes:
                          'px-2 py-1 rounded-full border border-dashed border-outline-variant hover:border-primary text-outline text-xs',
                      [Component.text('+ وسم')],
                    ),
                  ]),
                ]),
              ],
            ),

            // 3. Inventory & Low-Stock Alerts Card
            div(
              classes:
                  'bg-surface-container-lowest p-space-lg rounded-2xl border border-surface-container-high/40 shadow-sm space-y-4',
              [
                h3(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface flex items-center gap-2', [
                  span(classes: 'material-symbols-outlined text-primary text-[20px]', [Component.text('inventory')]),
                  Component.text('إدارة المخزون والتنبيهات'),
                ]),

                div([
                  label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                    Component.text('الكمية الإجمالية بالمستودع *'),
                  ]),
                  input(
                    classes:
                        'w-full h-11 px-4 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-body-md focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                    type: InputType.number,
                    value: stock,
                    attributes: {'placeholder': '42'},
                  ),
                ]),

                div([
                  label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                    Component.text('حد التنبيه بانخفاض المخزون'),
                  ]),
                  input(
                    classes:
                        'w-full h-11 px-4 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-body-md focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                    type: InputType.number,
                    value: lowStockThreshold,
                    attributes: {'placeholder': '5'},
                  ),
                  p(classes: 'text-[11px] text-outline mt-1', [
                    Component.text('سيتم إرسال إشعار لك فور وصول المخزون لهذه الكمية.'),
                  ]),
                ]),

                div(classes: 'p-3 rounded-xl bg-emerald-50 text-emerald-800 text-xs flex items-center gap-2', [
                  span(classes: 'material-symbols-outlined text-[18px] text-emerald-600', [Component.text('verified')]),
                  Component.text('المخزون متوفر بنسبة ممتازة ولا يوجد نقص حالياً.'),
                ]),
              ],
            ),

            // 4. Firebase Cloud Sync Card
            div(
              classes:
                  'bg-gradient-to-br from-surface-container-lowest to-surface-container-low p-space-lg rounded-2xl border border-surface-container-high/40 shadow-sm space-y-3',
              [
                div(classes: 'flex items-center justify-between', [
                  div(classes: 'flex items-center gap-2', [
                    span(classes: 'w-2.5 h-2.5 rounded-full bg-emerald-500 animate-ping', []),
                    span(classes: 'font-label-md text-label-md font-bold text-on-surface', [
                      Component.text('Firebase Sync'),
                    ]),
                  ]),
                  span(classes: 'text-[10px] font-bold text-emerald-700 bg-emerald-100 px-2 py-0.5 rounded-md', [
                    Component.text('Firestore Live'),
                  ]),
                ]),
                p(classes: 'text-xs text-outline leading-relaxed', [
                  Component.text(
                    'يتم رفع وتحديث بيانات المنتج في مجلد products وتحديث مؤشر الكتالوج في تطبيق Flutter تلقائياً.',
                  ),
                ]),
                div(classes: 'pt-2 flex items-center justify-between text-xs font-mono text-outline', [
                  Component.text('Collection: /products'),
                  Component.text('Status: Ready'),
                ]),
              ],
            ),
          ]),
        ]),
      ],
    );
  }
}
