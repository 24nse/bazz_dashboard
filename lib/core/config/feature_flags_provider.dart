import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'feature_flags.dart';

/// Notifier managing dynamic feature flags state across the app.
class FeatureFlagsNotifier extends Notifier<FeatureFlagsConfig> {
  @override
  FeatureFlagsConfig build() {
    return FeatureFlagsConfig.mvp();
  }

  /// Toggle an individual feature flag dynamically at runtime.
  void toggleFeature(AppFeature feature, bool isEnabled) {
    state = state.copyWith({feature: isEnabled});
  }

  /// Enable all features (e.g. for super admin or full release).
  void enableAll() {
    state = FeatureFlagsConfig.allEnabled();
  }

  /// Reset back to initial MVP configuration.
  void resetToMvp() {
    state = FeatureFlagsConfig.mvp();
  }
}

/// Global provider for application feature flags.
final featureFlagsProvider =
    NotifierProvider<FeatureFlagsNotifier, FeatureFlagsConfig>(
  FeatureFlagsNotifier.new,
);

/// Granular selector: Watches only a single feature to prevent unnecessary rebuilds.
final isFeatureEnabledProvider = Provider.family<bool, AppFeature>((ref, feature) {
  final flags = ref.watch(featureFlagsProvider);
  return flags.isEnabled(feature);
});
