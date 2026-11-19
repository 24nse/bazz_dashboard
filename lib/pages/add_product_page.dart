import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';

import '../features/inventory/presentation/providers/inventory_providers.dart';
import '../services/firebase_service.dart';

/// The Add Product Page in Jaspr for Matjar Nabdh Admin Dashboard.
/// Implements full Firebase Firestore integration for project 'lipsak'.
class AddProductPage extends StatefulComponent {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  // Form state
  String nameAr = 'قميص أكسفورد قطني فاخر';
  String nameEn = 'Classic Oxford Cotton Shirt';
  String sku = 'SHIRT-OXF-01';
  String barcode = '628100923847';
  String description =
      'قميص رجالي مصنوع من القطن الطبيعي 100% عالي الجودة بتصميم كلاسيكي مريح مناسب للعمل والمناسبات الرسمية.';
  String category = 'cat_men_shirts';
  String brand = 'Zara';
  String price = '189';
  String discountPrice = '149';
  String stock = '35';
  String lowStockThreshold = '5';
  bool isTaxIncluded = true;
  bool isPublished = true;
  String targetCollection = 'Products';
  String imageUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuDWnaA1xderq1MlEPMwI9HNmHkmJW71LkSgseqGGboAEwdE-_wFaxzVPNtGUB0QMWakdritPZ4b9eKQqA1cCr74EHpJmdNws0zBmoOP8nW7v-5yulYG5WO_LunNrqSZYW8FOA45E2nfPjXvtp4eggUysjR5AmC2AJUMRmNjFdl5wv_4GZqk7a1pVxaDuTbhNcIbELLqAnTcIhTqzGQxdkAbjd6r0egLM0bN_8IgjpT_3c_BkTYczcaY';

  // Submission & Firebase state
  bool isLoading = false;
  bool isSaved = false;
  bool isNewCollectionCreated = false;
  String? savedDocId;
  String? errorMessage;
  String? errorCode;
  bool showConfigModal = false;

  // Collection existence check
  bool isCheckingCollection = false;
  bool? collectionAlreadyExists;

  // Firebase Config state for modal
  String configApiKey = '';
  String configProjectId = 'lipsak';
  String configAuthDomain = 'lipsak.firebaseapp.com';

  final List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  final List<String> selectedSizes = ['M', 'L', 'XL'];
  final List<Map<String, String>> colors = [
    {'name': 'أبيض', 'bg': 'bg-white', 'ring': 'ring-gray-300'},
    {'name': 'أزرق سماوي', 'bg': 'bg-sky-400', 'ring': 'ring-sky-500'},
    {'name': 'كحلي', 'bg': 'bg-blue-900', 'ring': 'ring-blue-900'},
    {'name': 'أسود', 'bg': 'bg-black', 'ring': 'ring-black'},
  ];
  String selectedColor = 'أبيض';

  // Real categories from lipsak Firestore
  final List<Map<String, String>> storeCategories = [
    {'id': 'cat_men_shirts', 'name': 'قمصان رجالية (cat_men_shirts)'},
    {'id': 'cat_men', 'name': 'ملابس رجالية (cat_men)'},
    {'id': 'cat_women', 'name': 'ملابس نسائية (cat_women)'},
    {'id': 'cat_kids', 'name': 'ملابس أطفال (cat_kids)'},
    {'id': 'shoes', 'name': 'أحذية وسنيكرز'},
  ];

  @override
  void initState() {
    super.initState();
    _loadFirebaseConfig();
    _checkTargetCollection();
  }

  void _loadFirebaseConfig() {
    final cfg = FirebaseService.getConfig();
    configProjectId = cfg['projectId']?.toString() ?? 'lipsak';
    configApiKey = cfg['apiKey']?.toString() ?? '';
    configAuthDomain = cfg['authDomain']?.toString() ?? '$configProjectId.firebaseapp.com';
  }

  Future<void> _checkTargetCollection() async {
    setState(() => isCheckingCollection = true);
    final res = await FirebaseService.checkCollection(targetCollection);
    setState(() {
      isCheckingCollection = false;
      collectionAlreadyExists = res['exists'] == true;
    });
  }

  void _resetForm() {
    setState(() {
      isSaved = false;
      savedDocId = null;
      errorMessage = null;
      errorCode = null;
      isNewCollectionCreated = false;
      nameAr = '';
      nameEn = '';
      sku = '';
      barcode = '';
      description = '';
      price = '';
      discountPrice = '';
      stock = '';
      lowStockThreshold = '5';
    });
  }

  Future<void> _saveProduct({bool publish = true}) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      errorCode = null;
      isSaved = false;
      savedDocId = null;
      isNewCollectionCreated = false;
    });

    final productData = {
      'collectionName': targetCollection,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'sku': sku,
      'barcode': barcode,
      'description': description,
      'price': double.tryParse(price) ?? 0.0,
      'discountPrice': double.tryParse(discountPrice) ?? 0.0,
      'stock': int.tryParse(stock) ?? 0,
      'lowStockThreshold': int.tryParse(lowStockThreshold) ?? 5,
      'category': category,
      'categoryId': category,
      'brand': brand,
      'isTaxIncluded': isTaxIncluded,
      'isPublished': publish,
      'sizes': selectedSizes,
      'color': selectedColor,
      'imageUrl': imageUrl,
      'status': publish ? 'active' : 'draft',
      'firebaseProject': configProjectId,
    };

    final result = await FirebaseService.addProduct(productData);

    if (result['success'] == true) {
      context.read(productsNotifierProvider.notifier).refresh();
    }

    setState(() {
      isLoading = false;
      if (result['success'] == true) {
        isSaved = true;
        savedDocId = result['id']?.toString() ?? 'unknown-id';
        isNewCollectionCreated = result['isNewCollection'] == true;
        collectionAlreadyExists = true;
      } else {
        errorMessage = result['error']?.toString() ?? 'فشل الاتصال بقاعدة بيانات Firebase';
        errorCode = result['code']?.toString();
      }
    });
  }

  void _saveConfig() {
    FirebaseService.setConfig({
      'apiKey': configApiKey,
      'projectId': configProjectId,
      'authDomain': configAuthDomain,
      'storageBucket': '$configProjectId.appspot.com',
    });
    setState(() {
      showConfigModal = false;
    });
    _checkTargetCollection();
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
              Component.text('إضافة منتج جديد إلى مشروع lipsak في Firebase'),
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
                  'px-4 py-2 rounded-full border border-surface-container-high bg-surface-container-lowest hover:bg-surface-container text-on-surface font-label-md text-label-md transition-all flex items-center gap-2 disabled:opacity-50',
              disabled: isLoading,
              events: {'click': (e) => _saveProduct(publish: false)},
              [
                span(classes: 'material-symbols-outlined text-[18px]', [Component.text('drafts')]),
                Component.text('حفظ كمسودة'),
              ],
            ),
            button(
              classes:
                  'px-6 py-2 rounded-full bg-primary hover:bg-primary-container text-on-primary font-label-md text-label-md font-bold shadow-md shadow-primary/20 active:scale-95 transition-all flex items-center gap-2 disabled:opacity-60 cursor-pointer',
              disabled: isLoading,
              events: {'click': (e) => _saveProduct(publish: true)},
              [
                if (isLoading)
                  span(classes: 'w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin', [])
                else
                  span(classes: 'material-symbols-outlined text-[20px]', [Component.text('cloud_done')]),
                Component.text(isLoading ? 'جارٍ الإضافة لقاعدة البيانات...' : 'حفظ ونشر في Firebase ($targetCollection)'),
              ],
            ),
          ]),
        ]),

        // 1. Pre-addition status: Collection existence notice
        if (collectionAlreadyExists == false && !isSaved)
          div(
            classes:
                'p-4 bg-sky-50 border-2 border-sky-300 rounded-2xl flex items-center justify-between text-sky-950 shadow-sm animate-fade-in',
            [
              div(classes: 'flex items-center gap-3', [
                div(classes: 'w-10 h-10 rounded-xl bg-sky-100 flex items-center justify-center text-sky-700 shrink-0', [
                  span(classes: 'material-symbols-outlined text-2xl', [Component.text('info')]),
                ]),
                div([
                  p(classes: 'font-bold font-label-md text-sky-950', [
                    Component.text('مجموعة "$targetCollection" غير موجودة حالياً في قاعدة بيانات $configProjectId.'),
                  ]),
                  p(classes: 'text-xs text-sky-800 mt-0.5', [
                    Component.text(
                      'في Firebase Firestore لا تظهر المجموعات إلا بعد كتابة أول مستند بداخلها. سيتم إنشاء مجموعة "$targetCollection" تلقائياً بمجرد ضغط "حفظ ونشر".',
                    ),
                  ]),
                ]),
              ]),
              span(classes: 'text-xs font-mono bg-sky-100 text-sky-800 font-bold px-3 py-1 rounded-lg shrink-0', [
                Component.text('Auto-Create on Save'),
              ]),
            ],
          ),

        // 2. Loading Notification banner
        if (isLoading)
          div(
            classes:
                'p-4 bg-indigo-50 border border-indigo-200 rounded-2xl flex items-center justify-between text-indigo-900 shadow-sm animate-pulse',
            [
              div(classes: 'flex items-center gap-3', [
                span(classes: 'w-6 h-6 border-2 border-indigo-600 border-t-transparent rounded-full animate-spin', []),
                div([
                  p(classes: 'font-bold font-label-md', [Component.text('جارٍ الاتصال بقاعدة بيانات Firebase Firestore...')]),
                  p(classes: 'text-xs text-indigo-700', [
                    Component.text('المشروع: "$configProjectId" | المجموعة المستهدفة: "/$targetCollection"'),
                  ]),
                ]),
              ]),
            ],
          ),

        // 3. Success Notification banner
        if (isSaved)
          div(
            classes:
                'p-5 bg-emerald-50 border-2 border-emerald-400 rounded-2xl flex flex-wrap items-center justify-between gap-4 text-emerald-950 shadow-md animate-fade-in',
            [
              div(classes: 'flex items-center gap-3.5', [
                div(classes: 'w-11 h-11 rounded-full bg-emerald-100 flex items-center justify-center text-emerald-600 shrink-0 shadow-sm', [
                  span(classes: 'material-symbols-outlined text-2xl', [Component.text('check_circle')]),
                ]),
                div([
                  h3(classes: 'font-bold text-base text-emerald-950 flex items-center gap-2', [
                    if (isNewCollectionCreated)
                      Component.text('🎉 تم إنشاء مجموعة "$targetCollection" بنجاح وإضافة المنتج إليها في قاعدة بيانات $configProjectId!')
                    else
                      Component.text('✅ تم حفظ المنتج بنجاح في مجموعة "$targetCollection" بمشروع $configProjectId!'),
                  ]),
                  div(classes: 'text-xs text-emerald-800 mt-1 flex flex-wrap items-center gap-3', [
                    span([
                      Component.text('المشروع: '),
                      strong([Component.text(configProjectId)]),
                    ]),
                    span([
                      Component.text('المجموعة: '),
                      strong([Component.text('/$targetCollection')]),
                    ]),
                    if (savedDocId != null) ...[
                      span([
                        Component.text('معرّف المستند (Doc ID): '),
                        code(classes: 'bg-emerald-100 px-2 py-0.5 rounded font-mono text-[11px] font-bold text-emerald-900', [
                          Component.text(savedDocId!),
                        ]),
                      ]),
                    ],
                  ]),
                  p(classes: 'text-[11px] text-emerald-700 font-semibold mt-1.5 flex items-center gap-1', [
                    span(classes: 'material-symbols-outlined text-[14px]', [Component.text('refresh')]),
                    Component.text('ملاحظة: افتح Firebase Console واضغط Refresh (F5) لتظهر لك مجموعة $targetCollection والمستند فوراً في الشجرة.'),
                  ]),
                ]),
              ]),
              div(classes: 'flex items-center gap-2.5', [
                button(
                  classes: 'px-4 py-2 bg-emerald-600 hover:bg-emerald-700 text-white rounded-xl text-xs font-bold transition-all shadow-sm flex items-center gap-1.5 cursor-pointer',
                  events: {'click': (e) => _resetForm()},
                  [
                    span(classes: 'material-symbols-outlined text-[16px]', [Component.text('add')]),
                    Component.text('إضافة منتج آخر'),
                  ],
                ),
                a(
                  classes: 'px-4 py-2 bg-white hover:bg-emerald-100/60 border border-emerald-300 text-emerald-800 rounded-xl text-xs font-bold transition-all flex items-center gap-1.5',
                  href: '/products',
                  [
                    span(classes: 'material-symbols-outlined text-[16px]', [Component.text('inventory_2')]),
                    Component.text('عرض في قائمة المنتجات'),
                  ],
                ),
                button(
                  classes: 'text-emerald-700 hover:text-emerald-900 p-1',
                  events: {'click': (e) => setState(() => isSaved = false)},
                  [span(classes: 'material-symbols-outlined text-[20px]', [Component.text('close')])],
                ),
              ]),
            ],
          ),

        // 4. Error Notification banner (Explicit message when product not added / not found)
        if (errorMessage != null)
          div(
            classes:
                'p-5 bg-red-50 border-2 border-red-300 rounded-2xl space-y-3 text-red-950 shadow-md animate-fade-in',
            [
              div(classes: 'flex items-start justify-between gap-3', [
                div(classes: 'flex items-start gap-3', [
                  div(classes: 'w-10 h-10 rounded-xl bg-red-100 flex items-center justify-center text-red-600 shrink-0 mt-0.5', [
                    span(classes: 'material-symbols-outlined text-2xl', [Component.text('error')]),
                  ]),
                  div([
                    h3(classes: 'font-bold text-base text-red-950', [
                      Component.text('⚠️ لم يتم العثور على المنتج في قاعدة البيانات (فشل الحفظ في مجموعة $targetCollection)'),
                    ]),
                    p(classes: 'text-xs text-red-800 font-mono mt-1 bg-red-100/70 p-2 rounded-lg', [
                      Component.text('رسالة الخطأ: $errorMessage'),
                      if (errorCode != null) Component.text(' (Code: $errorCode)'),
                    ]),
                  ]),
                ]),
                button(
                  classes: 'text-red-700 hover:text-red-900 p-1',
                  events: {'click': (e) => setState(() => errorMessage = null)},
                  [span(classes: 'material-symbols-outlined text-[20px]', [Component.text('close')])],
                ),
              ]),

              // Diagnostic Checklist to solve the issue
              div(classes: 'bg-white p-3.5 rounded-xl border border-red-200 text-xs space-y-2', [
                p(classes: 'font-bold text-red-900', [
                  Component.text('أسباب عدم ظهور المنتج في Firebase Console وحلولها:'),
                ]),
                ul(classes: 'list-disc list-inside space-y-1 text-on-surface-variant', [
                  li([
                    Component.text('اسم المشروع: تأكد أنك تستخدم '),
                    strong([Component.text('lipsak')]),
                    Component.text(' (كما في شاشتك).'),
                  ]),
                  li([
                    Component.text('مفتاح Web API Key: لم يتم تعيين مفتاح الـ API بعد. احصل عليه من '),
                    strong([Component.text('Firebase Console > Project settings (⚙️) > General > Your apps')]),
                    Component.text(' وضعه في إعدادات الربط أدناه.'),
                  ]),
                  li([
                    Component.text('قواعد أمان Firestore: تأكد من السماح بالكتابة في تبويب '),
                    strong([Component.text('Firestore Database > Rules')]),
                    Component.text(' بكتابة '),
                    code(classes: 'bg-surface-container px-1 py-0.5 rounded text-primary', [
                      Component.text('allow read, write: if true;'),
                    ]),
                  ]),
                ]),
                div(classes: 'pt-2 flex items-center gap-2', [
                  button(
                    classes: 'px-4 py-2 bg-primary hover:bg-primary-container text-white rounded-lg text-xs font-bold transition-all flex items-center gap-1.5 cursor-pointer',
                    events: {'click': (e) => setState(() => showConfigModal = true)},
                    [
                      span(classes: 'material-symbols-outlined text-[16px]', [Component.text('settings')]),
                      Component.text('إدخال مفتاح الـ Web API Key وحفظ الإعدادات'),
                    ],
                  ),
                  button(
                    classes: 'px-4 py-2 bg-surface-container hover:bg-surface-container-high text-on-surface rounded-lg text-xs font-bold transition-all cursor-pointer',
                    events: {'click': (e) => _saveProduct(publish: true)},
                    [
                      span(classes: 'material-symbols-outlined text-[16px]', [Component.text('refresh')]),
                      Component.text('إعادة المحاولة الآن'),
                    ],
                  ),
                ]),
              ]),
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
                    Component.text('Firebase Storage / Cloud'),
                  ]),
                ]),

                // Image URL input
                div([
                  label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                    Component.text('رابط صورة المنتج (Image / Thumbnail URL)'),
                  ]),
                  input(
                    id: 'input-image-url',
                    classes:
                        'w-full h-11 px-4 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-mono text-xs focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                    type: InputType.text,
                    value: imageUrl,
                    attributes: {
                      'dir': 'ltr',
                      'placeholder': 'https://example.com/image.png',
                    },
                  ),
                ]),

                // Thumbnails Gallery
                div(classes: 'flex flex-wrap items-center gap-3 pt-1', [
                  // Image 1 (Main)
                  div(
                    classes:
                        'relative w-24 h-24 rounded-2xl overflow-hidden border-2 border-primary group shadow-sm bg-surface-container',
                    [
                      img(
                        id: 'img-preview',
                        classes: 'w-full h-full object-cover',
                        src: imageUrl,
                        alt: 'صورة المنتج الرئيسية',
                      ),
                      span(
                        classes:
                            'absolute top-1.5 right-1.5 bg-primary text-on-primary text-[10px] px-1.5 py-0.5 rounded-full font-bold shadow-sm',
                        [Component.text('الرئيسية')],
                      ),
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
                      Component.text('اسم المنتج باللغة العربية (Name / Title) *'),
                    ]),
                    input(
                      id: 'input-name-ar',
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
                      id: 'input-name-en',
                      classes:
                          'w-full h-11 px-4 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-body-md text-left focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                      type: InputType.text,
                      value: nameEn,
                      attributes: {'dir': 'ltr', 'placeholder': 'e.g. Classic Oxford Cotton Shirt'},
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
                          id: 'input-sku',
                          classes:
                              'w-full h-11 px-4 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-mono text-sm focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                          type: InputType.text,
                          value: sku,
                          attributes: {'dir': 'ltr', 'placeholder': 'SHIRT-OXF-01'},
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
                          id: 'input-barcode',
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
                      Component.text('الوصف التفصيلي للمنتج (Description)'),
                    ]),
                    textarea(
                      id: 'input-description',
                      classes:
                          'w-full p-3.5 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-body-md focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                      attributes: {
                        'rows': '4',
                        'placeholder': 'اكتب وصفاً جذاباً يشمل تفاصيل الخامة، مميزات الاستخدام، وملاحظات المقاس...',
                      },
                      [
                        Component.text(description),
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
                      Component.text('السعر الأساسي الأصلي (Price) *'),
                    ]),
                    div(classes: 'relative', [
                      input(
                        id: 'input-price',
                        classes:
                            'w-full h-11 pr-4 pl-14 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-price-sm text-price-sm focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                        type: InputType.number,
                        value: price,
                        attributes: {'placeholder': '189'},
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
                      Component.text('سعر البيع المخفض (SalePrice)'),
                    ]),
                    div(classes: 'relative', [
                      input(
                        id: 'input-discount-price',
                        classes:
                            'w-full h-11 pr-4 pl-14 rounded-xl border border-outline-variant/60 bg-surface text-emerald-700 font-price-sm text-price-sm font-bold focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                        type: InputType.number,
                        value: discountPrice,
                        attributes: {'placeholder': '149'},
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
                          span(classes: 'material-symbols-outlined text-[14px] hover:opacity-75', [Component.text('check')]),
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
                        events: {'click': (e) => setState(() => selectedColor = c['name']!)},
                        [
                          if (selectedColor == c['name'])
                            span(
                              classes:
                                  'material-symbols-outlined text-[18px] ${c['name'] == 'أبيض' ? 'text-black' : 'text-white'}',
                              [Component.text('check')],
                            ),
                        ],
                      ),
                  ]),
                ]),
              ],
            ),
          ]),

          // Right Column (Sidebar style, 1/3): Status, Category & Inventory & Firebase Card
          div(classes: 'space-y-space-xl', [
            // 1. Firebase Cloud Sync Card (Enhanced with Target Collection)
            div(
              classes:
                  'bg-gradient-to-br from-surface-container-lowest to-surface-container-low p-space-lg rounded-2xl border-2 border-primary/20 shadow-md space-y-4',
              [
                div(classes: 'flex items-center justify-between', [
                  div(classes: 'flex items-center gap-2', [
                    span(classes: 'w-2.5 h-2.5 rounded-full bg-emerald-500 animate-ping', []),
                    span(classes: 'font-label-md text-label-md font-bold text-on-surface', [
                      Component.text('مشروع Firebase: '),
                      span(classes: 'text-primary font-mono', [Component.text(configProjectId)]),
                    ]),
                  ]),
                  span(classes: 'text-[11px] font-bold text-emerald-700 bg-emerald-100 px-2 py-0.5 rounded-md flex items-center gap-1', [
                    span(classes: 'material-symbols-outlined text-[12px]', [Component.text('cloud_done')]),
                    Component.text('Firestore Live'),
                  ]),
                ]),

                div(classes: 'space-y-2 text-xs text-outline bg-surface-container-lowest/90 p-3.5 rounded-xl border border-surface-container-high/60', [
                  div(classes: 'flex justify-between items-center', [
                    Component.text('المجموعة (Collection):'),
                    span(classes: 'font-mono text-primary font-bold bg-primary-fixed/40 px-2 py-0.5 rounded', [
                      Component.text('/$targetCollection'),
                    ]),
                  ]),
                  div(classes: 'flex justify-between items-center', [
                    Component.text('حالة المجموعة بالـ DB:'),
                    if (isCheckingCollection)
                      span(classes: 'text-outline', [Component.text('جارٍ الفحص...')])
                    else if (collectionAlreadyExists == true)
                      span(classes: 'text-emerald-600 font-bold flex items-center gap-1', [
                        span(classes: 'material-symbols-outlined text-[13px]', [Component.text('check_circle')]),
                        Component.text('موجودة وبها مستندات'),
                      ])
                    else
                      span(classes: 'text-amber-600 font-bold flex items-center gap-1', [
                        span(classes: 'material-symbols-outlined text-[13px]', [Component.text('info')]),
                        Component.text('ستُنشأ تلقائياً عند الحفظ'),
                      ]),
                  ]),
                  div(classes: 'flex justify-between items-center', [
                    Component.text('المجموعات الشقيقة:'),
                    span(classes: 'font-mono text-on-surface-variant text-[11px]', [
                      Component.text('Banners, Categories, Users'),
                    ]),
                  ]),
                ]),

                // Target collection chooser
                div([
                  label(classes: 'block text-xs font-semibold text-on-surface mb-1', [
                    Component.text('اسم مجموعة الحفظ في Firestore:'),
                  ]),
                  div(classes: 'flex gap-2', [
                    button(
                      classes:
                          'flex-1 py-1.5 px-2 rounded-lg text-xs font-bold transition-all border ${targetCollection == "Products" ? "bg-primary text-white border-primary shadow-sm" : "bg-surface-container border-surface-container-high text-on-surface"}',
                      events: {'click': (e) {
                        setState(() => targetCollection = 'Products');
                        _checkTargetCollection();
                      }},
                      [Component.text('Products (موصى بها)')],
                    ),
                    button(
                      classes:
                          'flex-1 py-1.5 px-2 rounded-lg text-xs font-bold transition-all border ${targetCollection == "products" ? "bg-primary text-white border-primary shadow-sm" : "bg-surface-container border-surface-container-high text-on-surface"}',
                      events: {'click': (e) {
                        setState(() => targetCollection = 'products');
                        _checkTargetCollection();
                      }},
                      [Component.text('products')],
                    ),
                  ]),
                ]),

                button(
                  classes:
                      'w-full py-2 px-3 rounded-xl border border-primary/30 hover:border-primary bg-primary/5 hover:bg-primary/10 text-primary text-xs font-bold transition-all flex items-center justify-center gap-1.5 cursor-pointer',
                  events: {'click': (e) => setState(() => showConfigModal = true)},
                  [
                    span(classes: 'material-symbols-outlined text-[16px]', [Component.text('tune')]),
                    Component.text('إعدادات ربط Firebase (API Key / Project)'),
                  ],
                ),
              ],
            ),

            // 2. Category Selection (Matches categories from screenshot: cat_men_shirts, etc.)
            div(
              classes:
                  'bg-surface-container-lowest p-space-lg rounded-2xl border border-surface-container-high/40 shadow-sm space-y-4',
              [
                h3(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface flex items-center gap-2', [
                  span(classes: 'material-symbols-outlined text-primary text-[20px]', [Component.text('category')]),
                  Component.text('القسم والماركة (Categories)'),
                ]),

                // Category Select
                div([
                  label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                    Component.text('القسم من مجموعة Categories في Firebase *'),
                  ]),
                  div(classes: 'relative', [
                    select(
                      id: 'input-category',
                      classes:
                          'w-full h-11 pr-3 pl-9 rounded-xl border border-outline-variant/60 bg-surface text-on-surface text-body-md focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none cursor-pointer appearance-none',
                      [
                        for (final c in storeCategories)
                          option(
                            value: c['id']!,
                            selected: category == c['id'],
                            [Component.text(c['name']!)],
                          ),
                      ],
                    ),
                    span(
                      classes:
                          'material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-outline pointer-events-none text-[20px]',
                      [Component.text('expand_more')],
                    ),
                  ]),
                  p(classes: 'text-[11px] text-outline mt-1', [
                    Component.text('يتطابق مع مستندات Categories في Firebase: cat_men_shirts, cat_men...'),
                  ]),
                ]),

                // Brand Select
                div([
                  label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                    Component.text('الماركة التجارية (Brand)'),
                  ]),
                  div(classes: 'relative', [
                    select(
                      id: 'input-brand',
                      classes:
                          'w-full h-11 pr-3 pl-9 rounded-xl border border-outline-variant/60 bg-surface text-on-surface text-body-md focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none cursor-pointer appearance-none',
                      [
                        option(value: 'Zara', selected: brand == 'Zara', [Component.text('Zara')]),
                        option(value: 'Nike', selected: brand == 'Nike', [Component.text('Nike')]),
                        option(value: 'Adidas', selected: brand == 'Adidas', [Component.text('Adidas')]),
                        option(value: 'Puma', selected: brand == 'Puma', [Component.text('Puma')]),
                        option(value: 'Apple', selected: brand == 'Apple', [Component.text('Apple')]),
                      ],
                    ),
                    span(
                      classes:
                          'material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-outline pointer-events-none text-[20px]',
                      [Component.text('expand_more')],
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
                  Component.text('إدارة المخزون (Stock)'),
                ]),

                div([
                  label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                    Component.text('الكمية الإجمالية بالمستودع *'),
                  ]),
                  input(
                    id: 'input-stock',
                    classes:
                        'w-full h-11 px-4 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-body-md focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                    type: InputType.number,
                    value: stock,
                    attributes: {'placeholder': '35'},
                  ),
                ]),

                div([
                  label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                    Component.text('حد التنبيه بانخفاض المخزون'),
                  ]),
                  input(
                    id: 'input-low-stock',
                    classes:
                        'w-full h-11 px-4 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-body-md focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                    type: InputType.number,
                    value: lowStockThreshold,
                    attributes: {'placeholder': '5'},
                  ),
                ]),
              ],
            ),
          ]),
        ]),

        // Firebase Configuration Modal
        if (showConfigModal)
          div(
            classes:
                'fixed inset-0 bg-black/60 backdrop-blur-sm z-50 flex items-center justify-center p-4 animate-fade-in',
            [
              div(
                classes:
                    'bg-surface-container-lowest max-w-lg w-full rounded-2xl shadow-2xl border border-surface-container-high overflow-hidden space-y-4 p-6',
                [
                  div(classes: 'flex items-center justify-between pb-3 border-b border-surface-container-high/60', [
                    div(classes: 'flex items-center gap-2.5', [
                      span(classes: 'material-symbols-outlined text-primary text-2xl', [Component.text('settings')]),
                      h3(classes: 'font-bold text-lg text-on-surface', [Component.text('إعدادات ربط Firebase (مشروع lipsak)')]),
                    ]),
                    button(
                      classes: 'text-outline hover:text-on-surface p-1 cursor-pointer',
                      events: {'click': (e) => setState(() => showConfigModal = false)},
                      [span(classes: 'material-symbols-outlined text-[20px]', [Component.text('close')])],
                    ),
                  ]),

                  div(classes: 'space-y-3 text-sm', [
                    div([
                      label(classes: 'block font-semibold text-xs text-on-surface mb-1', [
                        Component.text('Firebase Project ID *'),
                      ]),
                      input(
                        classes:
                            'w-full h-10 px-3 rounded-xl border border-outline-variant/60 bg-surface font-mono text-xs text-left focus:border-primary outline-none',
                        type: InputType.text,
                        value: configProjectId,
                        attributes: {'dir': 'ltr'},
                      ),
                      p(classes: 'text-[11px] text-outline mt-0.5', [
                        Component.text('اسم مشروعك في Firebase هو lipsak (طبقاً لصورة الكونسول)'),
                      ]),
                    ]),

                    div([
                      label(classes: 'block font-semibold text-xs text-on-surface mb-1', [
                        Component.text('Web API Key (من Firebase Console) *'),
                      ]),
                      input(
                        classes:
                            'w-full h-10 px-3 rounded-xl border border-outline-variant/60 bg-surface font-mono text-xs text-left focus:border-primary outline-none',
                        type: InputType.text,
                        value: configApiKey,
                        attributes: {'dir': 'ltr', 'placeholder': 'AIzaSy...'},
                      ),
                      p(classes: 'text-[11px] text-outline mt-0.5', [
                        Component.text('افتح Firebase Console > Project settings (⚙️) > General > انسخ Web API Key'),
                      ]),
                    ]),

                    div([
                      label(classes: 'block font-semibold text-xs text-on-surface mb-1', [
                        Component.text('Auth Domain'),
                      ]),
                      input(
                        classes:
                            'w-full h-10 px-3 rounded-xl border border-outline-variant/60 bg-surface font-mono text-xs text-left focus:border-primary outline-none',
                        type: InputType.text,
                        value: configAuthDomain,
                        attributes: {'dir': 'ltr'},
                      ),
                    ]),
                  ]),

                  div(classes: 'pt-3 border-t border-surface-container-high/60 flex items-center justify-end gap-2', [
                    button(
                      classes: 'px-4 py-2 rounded-xl text-xs font-semibold text-outline hover:text-on-surface cursor-pointer',
                      events: {'click': (e) => setState(() => showConfigModal = false)},
                      [Component.text('إلغاء')],
                    ),
                    button(
                      classes: 'px-5 py-2 rounded-xl bg-primary hover:bg-primary-container text-white text-xs font-bold shadow-sm cursor-pointer',
                      events: {'click': (e) => _saveConfig()},
                      [Component.text('حفظ الإعدادات والتفعيل')],
                    ),
                  ]),
                ],
              ),
            ],
          ),
      ],
    );
  }
}
