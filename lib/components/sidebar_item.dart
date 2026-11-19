import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import '../core/config/feature_flags.dart';
import '../core/config/feature_flags_provider.dart';

/// Reusable Side Menu Item component that automatically respects Feature Flags.
/// When the designated [feature] is disabled, it returns an empty component.
class SideMenuItem extends StatelessComponent {
  final AppFeature feature;
  final String title;
  final String icon;
  final String href;
  final String? badgeText;
  final String? badgeClasses;
  final bool isSubItem;

  const SideMenuItem({
    super.key,
    required this.feature,
    required this.title,
    required this.icon,
    required this.href,
    this.badgeText,
    this.badgeClasses,
    this.isSubItem = false,
  });

  @override
  Component build(BuildContext context) {
    // Dynamically watch the specific feature flag via Riverpod
    final isEnabled = context.watch(isFeatureEnabledProvider(feature));
    if (!isEnabled) {
      return Component.text('');
    }

    if (isSubItem) {
      return a(
        classes:
            'flex items-center justify-between px-3 py-2 rounded-xl text-primary font-semibold bg-primary/5 hover:bg-primary/10 transition-all duration-150 mr-4',
        href: href,
        [
          div(classes: 'flex items-center gap-2', [
            span(
              classes: 'material-symbols-outlined text-[18px]',
              attributes: {'data-icon': icon},
              [Component.text(icon)],
            ),
            span(classes: 'font-label-sm text-label-sm', [
              Component.text(title),
            ]),
          ]),
          if (badgeText != null)
            span(
              classes: badgeClasses ??
                  'text-[10px] bg-primary text-on-primary px-1.5 py-0.2 rounded font-bold',
              [Component.text(badgeText!)],
            ),
        ],
      );
    }

    return a(
      classes:
          'flex items-center justify-between px-3.5 py-3 rounded-xl text-on-surface-variant hover:bg-surface-container hover:text-primary transition-all duration-150 group',
      href: href,
      [
        div(classes: 'flex items-center gap-3', [
          span(
            classes:
                'material-symbols-outlined text-[20px] text-outline group-hover:text-primary transition-colors',
            attributes: {'data-icon': icon},
            [Component.text(icon)],
          ),
          span(classes: 'font-label-md text-label-md', [
            Component.text(title),
          ]),
        ]),
        if (badgeText != null)
          span(
            classes: badgeClasses ??
                'bg-surface-container-high text-on-surface-variant group-hover:bg-primary-fixed group-hover:text-primary font-label-sm text-label-sm px-2 py-0.5 rounded-full transition-colors',
            [Component.text(badgeText!)],
          ),
      ],
    );
  }
}
