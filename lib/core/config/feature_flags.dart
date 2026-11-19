/// Application feature flags enum and configuration.
/// Used to dynamically toggle visibility of modules across the dashboard.
library;

enum AppFeature {
  dashboard, // الرئيسية والإحصائيات
  productsInventory, // المنتجات والمخزون
  ordersShipments, // الطلبات والشحنات
  categories, // الأقسام والتصنيفات
  customers, // العملاء والمستخدمين
  marketing, // التسويق والتقارير
  coupons, // الكوبونات والعروض
  reportsAnalytics, // التقارير والمبيعات
  storeSettings, // إعدادات المتجر وFirebase
}

class FeatureFlagsConfig {
  final Map<AppFeature, bool> _flags;

  const FeatureFlagsConfig(this._flags);

  /// Default MVP flags configuration:
  /// Only [dashboard] and [productsInventory] are enabled.
  /// All other sections are temporarily hidden for data entry.
  factory FeatureFlagsConfig.mvp() {
    return const FeatureFlagsConfig({
      AppFeature.dashboard: true,
      AppFeature.productsInventory: true,
      AppFeature.ordersShipments: false,
      AppFeature.categories: false,
      AppFeature.customers: false,
      AppFeature.marketing: false,
      AppFeature.coupons: false,
      AppFeature.reportsAnalytics: false,
      AppFeature.storeSettings: false,
    });
  }

  /// Full production configuration: all modules enabled.
  factory FeatureFlagsConfig.allEnabled() {
    return FeatureFlagsConfig({
      for (final feature in AppFeature.values) feature: true,
    });
  }

  /// Check whether a specific feature is currently enabled.
  bool isEnabled(AppFeature feature) => _flags[feature] ?? false;

  /// Returns a new instance with the specified overrides applied.
  FeatureFlagsConfig copyWith(Map<AppFeature, bool> overrides) {
    final updated = Map<AppFeature, bool>.from(_flags)..addAll(overrides);
    return FeatureFlagsConfig(updated);
  }
}
