import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';

import '../features/inventory/data/models/product_model.dart';
import '../features/inventory/presentation/providers/inventory_providers.dart';
import '../services/firebase_service.dart';

/// The Add / Edit Product Page in Jaspr for Matjar Nabdh Vendor Dashboard.
/// Strictly integrates with the flat NoSQL Firestore schema for root collection 'products'.
class AddProductPage extends StatefulComponent {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  // --- Exact Firestore Schema State (Root collection 'products') ---
  String storeId = 'store_01';
  String vendorId = 'vendor_01';
  String topTab = 'women'; // Main Department ('women', 'men', 'kids')
  String categoryId = 'women_dresses'; // Sub-category
  String title = 'فستان سهرة كريب راقي';
  String description =
      'فستان سهرة نسائي مصمم من خامة الكريب الفاخرة بقصة أنيقة ومريحة، ملائم للمناسبات الرسمية والاحتفالات.';
  String thumbnail =
      'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=500';
  String galleryImage1 =
      'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?w=500';
  String price = '299';
  String salePrice = '239';
  String saleLabel = 'خصم 20%';
  String stock = '25';
  double rating = 0.0;
  int reviewsCount = 0;
  bool isFeatured = false;
  bool isActive = true;

  // Root collection - strictly lowercase 'products' as per new schema
  String targetCollection = 'products';

  // Submission & Validation state
  bool isLoading = false;
  bool isSaved = false;
  String? savedDocId;
  String? errorMessage;
  String? errorCode;
  List<String> validationErrors = [];
  bool showConfigModal = false;

  // Collection existence check
  bool isCheckingCollection = false;
  bool? collectionAlreadyExists;

  // Firebase Config state for modal
  String configApiKey = '';
  String configProjectId = 'lipsak';
  String configAuthDomain = 'lipsak.firebaseapp.com';

  // --- Department Tabs & Sub-categories (Context-First) ---
  static const Map<String, String> departmentOptions = {
    'women': 'نساء (women)',
    'men': 'رجال (men)',
    'kids': 'أطفال (kids)',
  };

  static const Map<String, List<Map<String, String>>> subCategoriesByDept = {
    'women': [
      {'id': 'women_dresses', 'name': 'فساتين نسائية (women_dresses)'},
      {'id': 'women_abayas', 'name': 'عبايات وجلابيات (women_abayas)'},
      {'id': 'women_shoes', 'name': 'أحذية نسائية (women_shoes)'},
      {'id': 'women_bags', 'name': 'حقائب وإكسسوارات (women_bags)'},
      {'id': 'women_tops', 'name': 'بلايز وتنانير (women_tops)'},
    ],
    'men': [
      {'id': 'men_shirts', 'name': 'قمصان رجالية (men_shirts)'},
      {'id': 'men_thobes', 'name': 'أثواب وشماغ (men_thobes)'},
      {'id': 'men_shoes', 'name': 'أحذية وسنيكرز (men_shoes)'},
      {'id': 'men_pants', 'name': 'بنطلونات جينز وقماش (men_pants)'},
      {'id': 'men_accessories', 'name': 'ساعات وإكسسوارات (men_accessories)'},
    ],
    'kids': [
      {'id': 'kids_boys', 'name': 'ملابس أولاد (kids_boys)'},
      {'id': 'kids_girls', 'name': 'ملابس بنات (kids_girls)'},
      {'id': 'kids_shoes', 'name': 'أحذية أطفال (kids_shoes)'},
      {'id': 'kids_baby', 'name': 'مواليد ورضع (kids_baby)'},
    ],
  };

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

  void _onDepartmentChanged(String newDept) {
    setState(() {
      topTab = newDept;
      final subCats = subCategoriesByDept[newDept] ?? [];
      if (subCats.isNotEmpty) {
        categoryId = subCats.first['id']!;
      }
    });
  }

  void _recalcSaleLabel() {
    final p = double.tryParse(price) ?? 0.0;
    final sp = double.tryParse(salePrice) ?? 0.0;
    if (p > 0 && sp > 0 && sp < p) {
      final pct = (((p - sp) / p) * 100).round();
      setState(() => saleLabel = 'خصم $pct%');
    } else if (sp == 0 || sp >= p) {
      setState(() => saleLabel = '');
    }
  }

  List<String> _validateInputs() {
    final errors = <String>[];
    if (title.trim().isEmpty) errors.add('اسم المنتج (title) حقل إجباري.');
    if (storeId.trim().isEmpty) errors.add('معرف المتجر (storeId) حقل إجباري.');
    if (vendorId.trim().isEmpty) errors.add('معرف التاجر (vendorId) حقل إجباري.');
    if (topTab.trim().isEmpty) errors.add('القسم الرئيسي (topTab) حقل إجباري.');
    if (categoryId.trim().isEmpty) errors.add('التصنيف الفرعي (categoryId) حقل إجباري.');
    if (thumbnail.trim().isEmpty) errors.add('رابط صورة المنتج الرئيسية (thumbnail) إجباري.');

    final p = double.tryParse(price);
    if (p == null || p <= 0) {
      errors.add('السعر الأصلي (price) يجب أن يكون رقماً أكبر من صفر.');
    }

    final s = int.tryParse(stock);
    if (s == null || s < 0) {
      errors.add('الكمية بالمخزون (stock) يجب أن تكون 0 أو رقماً صحيحاً موجباً.');
    }

    final sp = double.tryParse(salePrice);
    if (sp != null && sp > 0 && p != null && sp >= p) {
      errors.add('سعر البيع المخفض (salePrice) يجب أن يكون أقل من السعر الأساسي (price).');
    }

    return errors;
  }

  void _resetForm() {
    setState(() {
      isSaved = false;
      savedDocId = null;
      errorMessage = null;
      errorCode = null;
      validationErrors = [];
      title = '';
      description = '';
      price = '';
      salePrice = '';
      saleLabel = '';
      stock = '0';
      thumbnail = '';
      galleryImage1 = '';
    });
  }

  Future<void> _saveProduct({bool publish = true}) async {
    // Validate inputs
    final errors = _validateInputs();
    if (errors.isNotEmpty) {
      setState(() {
        validationErrors = errors;
        errorMessage = 'يرجى مراجعة الحقول المطلوبة والتأكد من صحتها قبل الحفظ.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
      errorCode = null;
      validationErrors = [];
      isSaved = false;
      savedDocId = null;
      isActive = publish;
    });

    final p = double.tryParse(price) ?? 0.0;
    final sp = double.tryParse(salePrice) ?? 0.0;
    final s = int.tryParse(stock) ?? 0;

    final galleryList = <String>[];
    if (thumbnail.trim().isNotEmpty) galleryList.add(thumbnail.trim());
    if (galleryImage1.trim().isNotEmpty) galleryList.add(galleryImage1.trim());

    final productModel = ProductModel(
      storeId: storeId.trim(),
      vendorId: vendorId.trim(),
      categoryId: categoryId.trim(),
      topTab: topTab.trim(),
      title: title.trim(),
      description: description.trim(),
      thumbnail: thumbnail.trim(),
      images: galleryList,
      price: p,
      salePrice: sp,
      saleLabel: saleLabel.trim(),
      stock: s,
      rating: rating,
      reviewsCount: reviewsCount,
      isFeatured: isFeatured,
      isActive: publish,
    );

    // Save strictly to Firestore 'products' root collection
    final payload = productModel.toFirestore();
    payload['collectionName'] = targetCollection;

    final result = await FirebaseService.addProduct(payload);

    if (result['success'] == true) {
      context.read(productsNotifierProvider.notifier).refresh();
    }

    setState(() {
      isLoading = false;
      if (result['success'] == true) {
        isSaved = true;
        savedDocId = result['id']?.toString() ?? 'new_doc';
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
    final currentSubCategories = subCategoriesByDept[topTab] ?? [];

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
              Component.text('إضافة منتج جديد (Root Collection: $targetCollection)'),
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
                  'px-4 py-2 rounded-full border border-surface-container-high bg-surface-container-lowest hover:bg-surface-container text-on-surface font-label-md text-label-md transition-all flex items-center gap-2 disabled:opacity-50 cursor-pointer',
              disabled: isLoading,
              events: {'click': (e) => _saveProduct(publish: false)},
              [
                span(classes: 'material-symbols-outlined text-[18px]', [Component.text('drafts')]),
                Component.text('حفظ كمسودة غير نشطة'),
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
                Component.text(isLoading ? 'جارٍ الحفظ في Firestore...' : 'حفظ ونشر المنتج في Firestore'),
              ],
            ),
          ]),
        ]),

        // Validation Errors Banner
        if (validationErrors.isNotEmpty)
          div(
            classes:
                'p-4 bg-amber-50 border-2 border-amber-300 rounded-2xl text-amber-950 shadow-sm animate-fade-in space-y-2',
            [
              div(classes: 'flex items-center gap-2 font-bold text-sm text-amber-900', [
                span(classes: 'material-symbols-outlined text-[20px] text-amber-600', [Component.text('warning')]),
                Component.text('تنبيه: تعذر إرسال النموذج بسبب الأخطاء التالية:'),
              ]),
              ul(classes: 'list-disc list-inside text-xs space-y-1 text-amber-900 pr-4', [
                for (final err in validationErrors) li([Component.text(err)]),
              ]),
            ],
          ),

        // Pre-addition status: Collection notice
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
                    Component.text('المجموعة المستهدفة: /$targetCollection في مشروع $configProjectId'),
                  ]),
                  p(classes: 'text-xs text-sky-800 mt-0.5', [
                    Component.text('ستُنشأ المستندات طبقاً للهيكل المسطح NoSQL المتفق عليه فور ضغط حفظ.'),
                  ]),
                ]),
              ]),
              span(classes: 'text-xs font-mono bg-sky-100 text-sky-800 font-bold px-3 py-1 rounded-lg shrink-0', [
                Component.text('Root Collection: products'),
              ]),
            ],
          ),

        // Success Notification Banner
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
                    Component.text('✅ تم حفظ المنتج بنجاح في مجموعة /$targetCollection بمشروع $configProjectId!'),
                  ]),
                  div(classes: 'text-xs text-emerald-800 mt-1 flex flex-wrap items-center gap-3', [
                    span([
                      Component.text('معرف المستند (ID): '),
                      code(classes: 'bg-emerald-100 px-2 py-0.5 rounded font-mono text-[11px] font-bold text-emerald-900', [
                        Component.text(savedDocId ?? 'new_doc'),
                      ]),
                    ]),
                    span([Component.text('القسم: '), strong([Component.text(topTab)])]),
                    span([Component.text('التصنيف: '), strong([Component.text(categoryId)])]),
                    span([Component.text('السعر: '), strong([Component.text('$price ر.س')])]),
                    if (salePrice.isNotEmpty && salePrice != '0')
                      span([Component.text('سعر التخفيض: '), strong([Component.text('$salePrice ر.س')])]),
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
                  classes: 'text-emerald-700 hover:text-emerald-900 p-1 cursor-pointer',
                  events: {'click': (e) => setState(() => isSaved = false)},
                  [span(classes: 'material-symbols-outlined text-[20px]', [Component.text('close')])],
                ),
              ]),
            ],
          ),

        // Error Banner
        if (errorMessage != null && validationErrors.isEmpty)
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
                      Component.text('تعذر حفظ المنتج في Firestore (مجموعة $targetCollection)'),
                    ]),
                    p(classes: 'text-xs text-red-800 font-mono mt-1 bg-red-100/70 p-2 rounded-lg', [
                      Component.text('رسالة الخطأ: $errorMessage'),
                      if (errorCode != null) Component.text(' (Code: $errorCode)'),
                    ]),
                  ]),
                ]),
                button(
                  classes: 'text-red-700 hover:text-red-900 p-1 cursor-pointer',
                  events: {'click': (e) => setState(() => errorMessage = null)},
                  [span(classes: 'material-symbols-outlined text-[20px]', [Component.text('close')])],
                ),
              ]),
            ],
          ),

        // Main Two-Column Layout (Form Body)
        div(classes: 'grid grid-cols-1 lg:grid-cols-3 gap-space-xl items-start', [
          // Left Column (Wide, 2/3): Core Product Details & Media
          div(classes: 'lg:col-span-2 space-y-space-xl', [
            // 1. Basic Information Form Card
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
                  // Title (Required)
                  div([
                    label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                      Component.text('اسم المنتج (title) *'),
                    ]),
                    input(
                      id: 'input-title',
                      classes:
                          'w-full h-11 px-4 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-body-md focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                      type: InputType.text,
                      value: title,
                      events: {'input': (e) => title = (e.target as dynamic).value?.toString() ?? ''},
                      attributes: {'placeholder': 'أدخل اسم المنتج باللغة العربية'},
                    ),
                  ]),

                  // Description
                  div([
                    label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                      Component.text('الوصف التفصيلي (description)'),
                    ]),
                    textarea(
                      id: 'input-description',
                      classes:
                          'w-full p-3.5 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-body-md focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                      events: {'input': (e) => description = (e.target as dynamic).value?.toString() ?? ''},
                      attributes: {
                        'rows': '3',
                        'placeholder': 'اكتب وصفاً جذاباً يشمل تفاصيل الخامة، مميزات الاستخدام...',
                      },
                      [Component.text(description)],
                    ),
                  ]),
                ]),
              ],
            ),

            // 2. Pricing, Sale & Discounts Form Card
            div(
              classes:
                  'bg-surface-container-lowest p-space-lg rounded-2xl border border-surface-container-high/40 shadow-sm space-y-4',
              [
                div(classes: 'flex items-center justify-between pb-2 border-b border-surface-container-high/30', [
                  div(classes: 'flex items-center gap-2', [
                    span(classes: 'material-symbols-outlined text-primary text-[22px]', [Component.text('payments')]),
                    h2(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface', [
                      Component.text('التسعير والتخفيضات (price & salePrice)'),
                    ]),
                  ]),
                  span(classes: 'text-xs text-outline font-mono', [Component.text('Schema: price, salePrice, saleLabel')]),
                ]),

                div(classes: 'grid grid-cols-1 md:grid-cols-3 gap-4', [
                  // Base Price (price)
                  div([
                    label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                      Component.text('السعر الأساسي (price) *'),
                    ]),
                    div(classes: 'relative', [
                      input(
                        id: 'input-price',
                        classes:
                            'w-full h-11 pr-4 pl-14 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-price-sm text-price-sm focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                        type: InputType.number,
                        value: price,
                        events: {'input': (e) {
                          price = (e.target as dynamic).value?.toString() ?? '';
                          _recalcSaleLabel();
                        }},
                        attributes: {'placeholder': '299', 'step': '0.5'},
                      ),
                      span(
                        classes:
                            'absolute left-3.5 top-1/2 -translate-y-1/2 text-xs font-bold text-outline bg-surface-container px-2 py-0.5 rounded-md',
                        [Component.text('ر.س')],
                      ),
                    ]),
                  ]),

                  // Sale Price (salePrice)
                  div([
                    label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                      Component.text('سعر البيع المخفض (salePrice)'),
                    ]),
                    div(classes: 'relative', [
                      input(
                        id: 'input-sale-price',
                        classes:
                            'w-full h-11 pr-4 pl-14 rounded-xl border border-outline-variant/60 bg-surface text-emerald-700 font-price-sm text-price-sm font-bold focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                        type: InputType.number,
                        value: salePrice,
                        events: {'input': (e) {
                          salePrice = (e.target as dynamic).value?.toString() ?? '';
                          _recalcSaleLabel();
                        }},
                        attributes: {'placeholder': '239', 'step': '0.5'},
                      ),
                      span(
                        classes:
                            'absolute left-3.5 top-1/2 -translate-y-1/2 text-xs font-bold text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded-md',
                        [Component.text('ر.س')],
                      ),
                    ]),
                  ]),

                  // Sale Label (saleLabel)
                  div([
                    label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                      Component.text('ملصق التخفيض (saleLabel)'),
                    ]),
                    input(
                      id: 'input-sale-label',
                      classes:
                          'w-full h-11 px-4 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-body-md focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                      type: InputType.text,
                      value: saleLabel,
                      events: {'input': (e) => saleLabel = (e.target as dynamic).value?.toString() ?? ''},
                      attributes: {'placeholder': 'e.g. خصم 20%'},
                    ),
                  ]),
                ]),
              ],
            ),

            // 3. Media & Images Upload Box (thumbnail & images)
            div(
              classes:
                  'bg-surface-container-lowest p-space-lg rounded-2xl border border-surface-container-high/40 shadow-sm space-y-4',
              [
                div(classes: 'flex items-center justify-between pb-2 border-b border-surface-container-high/30', [
                  div(classes: 'flex items-center gap-2', [
                    span(classes: 'material-symbols-outlined text-primary text-[22px]', [Component.text('photo_library')]),
                    h2(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface', [
                      Component.text('صور المنتج (thumbnail & images)'),
                    ]),
                  ]),
                  span(classes: 'text-xs text-outline font-mono', [Component.text('List<String> images')]),
                ]),

                // Thumbnail URL
                div([
                  label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                    Component.text('رابط الصورة الرئيسية للمنتج (thumbnail) *'),
                  ]),
                  input(
                    id: 'input-thumbnail',
                    classes:
                        'w-full h-11 px-4 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-mono text-xs focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                    type: InputType.text,
                    value: thumbnail,
                    events: {'input': (e) => setState(() => thumbnail = (e.target as dynamic).value?.toString() ?? '')},
                    attributes: {
                      'dir': 'ltr',
                      'placeholder': 'https://example.com/thumbnail.png',
                    },
                  ),
                ]),

                // Gallery Extra Image
                div([
                  label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                    Component.text('صورة إضافية لمعرض الصور (gallery image)'),
                  ]),
                  input(
                    id: 'input-gallery-1',
                    classes:
                        'w-full h-11 px-4 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-mono text-xs focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                    type: InputType.text,
                    value: galleryImage1,
                    events: {'input': (e) => setState(() => galleryImage1 = (e.target as dynamic).value?.toString() ?? '')},
                    attributes: {
                      'dir': 'ltr',
                      'placeholder': 'https://example.com/gallery1.png',
                    },
                  ),
                ]),

                // Thumbnails Gallery Preview
                div(classes: 'flex flex-wrap items-center gap-4 pt-2', [
                  if (thumbnail.isNotEmpty)
                    div(classes: 'relative w-24 h-24 rounded-2xl overflow-hidden border-2 border-primary shadow-sm bg-surface-container', [
                      img(classes: 'w-full h-full object-cover', src: thumbnail, alt: 'صورة الغلاف'),
                      span(classes: 'absolute top-1.5 right-1.5 bg-primary text-on-primary text-[10px] px-1.5 py-0.5 rounded-full font-bold shadow-sm', [
                        Component.text('thumbnail'),
                      ]),
                    ]),
                  if (galleryImage1.isNotEmpty)
                    div(classes: 'relative w-24 h-24 rounded-2xl overflow-hidden border border-outline-variant/60 shadow-sm bg-surface-container', [
                      img(classes: 'w-full h-full object-cover', src: galleryImage1, alt: 'صورة إضافية'),
                      span(classes: 'absolute top-1.5 right-1.5 bg-black/70 text-white text-[10px] px-1.5 py-0.5 rounded-full font-bold', [
                        Component.text('معرض'),
                      ]),
                    ]),
                ]),
              ],
            ),
          ]),

          // Right Column (Sidebar style, 1/3): Categorization, Stock, Store & Vendor
          div(classes: 'space-y-space-xl', [
            // 1. Context-First Categorization (topTab & categoryId)
            div(
              classes:
                  'bg-surface-container-lowest p-space-lg rounded-2xl border border-surface-container-high/40 shadow-sm space-y-4',
              [
                h3(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface flex items-center gap-2 pb-2 border-b border-surface-container-high/30', [
                  span(classes: 'material-symbols-outlined text-primary text-[20px]', [Component.text('category')]),
                  Component.text('التصنيف والأقسام (topTab & categoryId)'),
                ]),

                // TopTab Dropdown (Main Department)
                div([
                  label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                    Component.text('القسم الرئيسي (topTab) *'),
                  ]),
                  div(classes: 'relative', [
                    select(
                      id: 'input-top-tab',
                      classes:
                          'w-full h-11 pr-3 pl-9 rounded-xl border border-outline-variant/60 bg-surface text-on-surface text-body-md focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none cursor-pointer appearance-none font-bold',
                      events: {'change': (e) {
                        final val = (e.target as dynamic).value?.toString() ?? 'women';
                        _onDepartmentChanged(val);
                      }},
                      [
                        for (final entry in departmentOptions.entries)
                          option(
                            value: entry.key,
                            selected: topTab == entry.key,
                            [Component.text(entry.value)],
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
                    Component.text('القسم الأساسي (Context-First): women, men, kids'),
                  ]),
                ]),

                // CategoryId Dropdown (Sub-category dynamically linked to topTab)
                div([
                  label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                    Component.text('التصنيف الفرعي (categoryId) *'),
                  ]),
                  div(classes: 'relative', [
                    select(
                      id: 'input-category-id',
                      classes:
                          'w-full h-11 pr-3 pl-9 rounded-xl border border-outline-variant/60 bg-surface text-on-surface text-body-md focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none cursor-pointer appearance-none',
                      events: {'change': (e) {
                        setState(() {
                          categoryId = (e.target as dynamic).value?.toString() ?? '';
                        });
                      }},
                      [
                        for (final c in currentSubCategories)
                          option(
                            value: c['id']!,
                            selected: categoryId == c['id'],
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
                    Component.text('معرف التصنيف الدقيق للفلترة، مثل women_dresses أو men_shirts'),
                  ]),
                ]),
              ],
            ),

            // 2. Inventory Management (stock)
            div(
              classes:
                  'bg-surface-container-lowest p-space-lg rounded-2xl border border-surface-container-high/40 shadow-sm space-y-4',
              [
                h3(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface flex items-center gap-2 pb-2 border-b border-surface-container-high/30', [
                  span(classes: 'material-symbols-outlined text-primary text-[20px]', [Component.text('inventory')]),
                  Component.text('المخزون والحالة (stock & status)'),
                ]),

                // Stock input
                div([
                  label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                    Component.text('الكمية المتوفرة بالمخزون (stock) *'),
                  ]),
                  input(
                    id: 'input-stock',
                    classes:
                        'w-full h-11 px-4 rounded-xl border border-outline-variant/60 bg-surface text-on-surface font-body-md focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all',
                    type: InputType.number,
                    value: stock,
                    events: {'input': (e) => stock = (e.target as dynamic).value?.toString() ?? '0'},
                    attributes: {'placeholder': '25'},
                  ),
                ]),

                // Active Switch
                div(classes: 'flex items-center justify-between pt-2 border-t border-surface-container-high/30', [
                  div([
                    p(classes: 'font-label-md text-label-md font-bold text-on-surface', [
                      Component.text('منتج نشط بالمتجر (isActive)'),
                    ]),
                    p(classes: 'text-xs text-outline', [Component.text('يظهر فوراً للمتسوقين في التطبيق')]),
                  ]),
                  input(
                    classes: 'w-5 h-5 rounded text-primary focus:ring-primary cursor-pointer',
                    type: InputType.checkbox,
                    checked: isActive,
                    events: {'change': (e) => setState(() => isActive = (e.target as dynamic).checked == true)},
                  ),
                ]),

                // Featured Switch
                div(classes: 'flex items-center justify-between pt-2 border-t border-surface-container-high/30', [
                  div([
                    p(classes: 'font-label-md text-label-md font-bold text-on-surface', [
                      Component.text('منتج مميز (isFeatured)'),
                    ]),
                    p(classes: 'text-xs text-outline', [Component.text('يظهر في أقسام المنتجات المميزة بالصفحة الرئيسية')]),
                  ]),
                  input(
                    classes: 'w-5 h-5 rounded text-primary focus:ring-primary cursor-pointer',
                    type: InputType.checkbox,
                    checked: isFeatured,
                    events: {'change': (e) => setState(() => isFeatured = (e.target as dynamic).checked == true)},
                  ),
                ]),
              ],
            ),

            // 3. Store & Vendor Identity
            div(
              classes:
                  'bg-surface-container-lowest p-space-lg rounded-2xl border border-surface-container-high/40 shadow-sm space-y-4',
              [
                h3(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface flex items-center gap-2 pb-2 border-b border-surface-container-high/30', [
                  span(classes: 'material-symbols-outlined text-primary text-[20px]', [Component.text('store')]),
                  Component.text('بيانات المتجر والتاجر (storeId & vendorId)'),
                ]),

                // StoreId
                div([
                  label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                    Component.text('معرف المتجر (storeId) *'),
                  ]),
                  input(
                    id: 'input-store-id',
                    classes:
                        'w-full h-11 px-4 rounded-xl border border-outline-variant/60 bg-surface font-mono text-xs focus:border-primary outline-none',
                    type: InputType.text,
                    value: storeId,
                    events: {'input': (e) => storeId = (e.target as dynamic).value?.toString() ?? ''},
                    attributes: {'dir': 'ltr'},
                  ),
                ]),

                // VendorId
                div([
                  label(classes: 'block font-label-md text-label-md font-semibold text-on-surface mb-1.5', [
                    Component.text('معرف التاجر (vendorId) *'),
                  ]),
                  input(
                    id: 'input-vendor-id',
                    classes:
                        'w-full h-11 px-4 rounded-xl border border-outline-variant/60 bg-surface font-mono text-xs focus:border-primary outline-none',
                    type: InputType.text,
                    value: vendorId,
                    events: {'input': (e) => vendorId = (e.target as dynamic).value?.toString() ?? ''},
                    attributes: {'dir': 'ltr'},
                  ),
                ]),

                // Target collection indicator
                div(classes: 'pt-2 border-t border-surface-container-high/30 flex items-center justify-between text-xs text-outline', [
                  Component.text('المجموعة المستهدفة:'),
                  span(classes: 'font-mono text-primary font-bold bg-primary-fixed/40 px-2 py-0.5 rounded', [
                    Component.text('/$targetCollection'),
                  ]),
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
                      h3(classes: 'font-bold text-lg text-on-surface', [Component.text('إعدادات ربط Firebase')]),
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
                        events: {'input': (e) => configProjectId = (e.target as dynamic).value?.toString() ?? ''},
                        attributes: {'dir': 'ltr'},
                      ),
                    ]),

                    div([
                      label(classes: 'block font-semibold text-xs text-on-surface mb-1', [
                        Component.text('Web API Key *'),
                      ]),
                      input(
                        classes:
                            'w-full h-10 px-3 rounded-xl border border-outline-variant/60 bg-surface font-mono text-xs text-left focus:border-primary outline-none',
                        type: InputType.text,
                        value: configApiKey,
                        events: {'input': (e) => configApiKey = (e.target as dynamic).value?.toString() ?? ''},
                        attributes: {'dir': 'ltr', 'placeholder': 'AIzaSy...'},
                      ),
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
                        events: {'input': (e) => configAuthDomain = (e.target as dynamic).value?.toString() ?? ''},
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
                      [Component.text('حفظ الإعدادات')],
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
