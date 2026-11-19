import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';

import '../core/config/feature_flags.dart';
import '../core/config/feature_flags_provider.dart';

class QuickActions extends StatelessComponent {
  const QuickActions({super.key});

  @override
  Component build(BuildContext context) {
    final flags = context.watch(featureFlagsProvider);

    return div(
      classes:
          'bg-gradient-to-br from-surface-container-lowest to-surface-container-low p-space-lg rounded-2xl shadow-[0_4px_20px_-2px_rgba(15,23,42,0.06)] border border-surface-container-high/40',
      [
        h3(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface mb-3', [
          Component.text('اختصارات إدارية سريعة'),
        ]),
        div(classes: 'grid grid-cols-1 gap-2.5', [
          // Quick Action: Add New Product (Always active in MVP)
          if (flags.isEnabled(AppFeature.productsInventory))
            a(
              classes:
                  'w-full flex items-center justify-between p-3 rounded-xl bg-primary/10 hover:bg-primary/15 border border-primary/20 text-primary transition-all group shadow-sm',
              href: '/add-product',
              [
                div(classes: 'flex items-center gap-3', [
                  div(classes: 'w-9 h-9 rounded-lg bg-primary text-on-primary flex items-center justify-center shadow-xs', [
                    span(
                      classes: 'material-symbols-outlined text-[20px]',
                      attributes: {'data-icon': 'add_circle'},
                      [Component.text('add_circle')],
                    ),
                  ]),
                  span(classes: 'font-label-md text-label-md font-bold', [
                    Component.text('إضافة منتج جديد للمتجر +'),
                  ]),
                ]),
                span(
                  classes:
                      'material-symbols-outlined text-primary group-hover:translate-x-[-2px] transition-transform text-[18px]',
                  attributes: {'data-icon': 'chevron_left'},
                  [Component.text('chevron_left')],
                ),
              ],
            ),

          // Quick Action 1: Export Sales (Gated by reportsAnalytics flag)
          if (flags.isEnabled(AppFeature.reportsAnalytics))
            button(
              classes:
                  'w-full flex items-center justify-between p-3 rounded-xl bg-surface-container-lowest hover:bg-surface-container border border-surface-container text-on-surface transition-all group',
              [
                div(classes: 'flex items-center gap-3', [
                  div(classes: 'w-9 h-9 rounded-lg bg-emerald-50 text-emerald-600 flex items-center justify-center', [
                    span(
                      classes: 'material-symbols-outlined text-[20px]',
                      attributes: {'data-icon': 'file_download'},
                      [Component.text('file_download')],
                    ),
                  ]),
                  span(classes: 'font-label-md text-label-md font-bold', [
                    Component.text('تصدير تقرير المبيعات (Excel/PDF)'),
                  ]),
                ]),
                span(
                  classes:
                      'material-symbols-outlined text-outline group-hover:text-primary transition-colors text-[18px]',
                  attributes: {'data-icon': 'chevron_left'},
                  [Component.text('chevron_left')],
                ),
              ],
            ),

          // Quick Action 2: Add Coupon (Gated by coupons flag)
          if (flags.isEnabled(AppFeature.coupons))
            button(
              classes:
                  'w-full flex items-center justify-between p-3 rounded-xl bg-surface-container-lowest hover:bg-surface-container border border-surface-container text-on-surface transition-all group',
              [
                div(classes: 'flex items-center gap-3', [
                  div(classes: 'w-9 h-9 rounded-lg bg-primary-fixed/70 text-primary flex items-center justify-center', [
                    span(
                      classes: 'material-symbols-outlined text-[20px]',
                      attributes: {'data-icon': 'sell'},
                      [Component.text('sell')],
                    ),
                  ]),
                  span(classes: 'font-label-md text-label-md font-bold', [
                    Component.text('إنشاء كود خصم أو قسيمة جديدة'),
                  ]),
                ]),
                span(
                  classes:
                      'material-symbols-outlined text-outline group-hover:text-primary transition-colors text-[18px]',
                  attributes: {'data-icon': 'chevron_left'},
                  [Component.text('chevron_left')],
                ),
              ],
            ),

          // Quick Action 3: Push Notification (Gated by marketing flag)
          if (flags.isEnabled(AppFeature.marketing))
            button(
              classes:
                  'w-full flex items-center justify-between p-3 rounded-xl bg-surface-container-lowest hover:bg-surface-container border border-surface-container text-on-surface transition-all group',
              [
                div(classes: 'flex items-center gap-3', [
                  div(classes: 'w-9 h-9 rounded-lg bg-amber-50 text-amber-600 flex items-center justify-center', [
                    span(
                      classes: 'material-symbols-outlined text-[20px]',
                      attributes: {'data-icon': 'campaign'},
                      [Component.text('campaign')],
                    ),
                  ]),
                  span(classes: 'font-label-md text-label-md font-bold', [
                    Component.text('إرسال إشعار ترويجي لمستخدمي التطبيق'),
                  ]),
                ]),
                span(
                  classes:
                      'material-symbols-outlined text-outline group-hover:text-primary transition-colors text-[18px]',
                  attributes: {'data-icon': 'chevron_left'},
                  [Component.text('chevron_left')],
                ),
              ],
            ),
        ]),
      ],
    );
  }
}
