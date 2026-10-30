import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class KpiCards extends StatelessComponent {
  const KpiCards({super.key});

  @override
  Component build(BuildContext context) {
    return section(classes: 'grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-space-md', [
      // Metric 1: Total Revenue
      div(
        classes:
            'bg-surface-container-lowest p-space-lg rounded-2xl shadow-[0_4px_20px_-2px_rgba(15,23,42,0.06)] border border-surface-container-high/40 flex flex-col justify-between hover:shadow-lg transition-shadow',
        [
          div(classes: 'flex items-center justify-between mb-3', [
            span(classes: 'font-label-md text-label-md text-outline', [Component.text('إجمالي المبيعات')]),
            div(classes: 'w-10 h-10 rounded-xl bg-primary-fixed/60 text-primary flex items-center justify-center', [
              span(
                classes: 'material-symbols-outlined text-[22px]',
                attributes: {'data-icon': 'payments'},
                [Component.text('payments')],
              ),
            ]),
          ]),
          div([
            div(classes: 'flex items-baseline gap-1', [
              span(classes: 'font-price-lg text-headline-md font-extrabold text-on-surface', [
                Component.text('148,920'),
              ]),
              span(classes: 'font-label-sm text-label-sm text-outline', [Component.text('ر.س')]),
            ]),
            div(classes: 'flex items-center gap-1.5 mt-2', [
              span(
                classes:
                    'inline-flex items-center text-emerald-600 bg-emerald-50 px-1.5 py-0.5 rounded font-label-sm text-label-sm font-bold',
                [
                  span(
                    classes: 'material-symbols-outlined text-[14px]',
                    attributes: {'data-icon': 'arrow_upward'},
                    [Component.text('arrow_upward')],
                  ),
                  Component.text(' +18.4%'),
                ],
              ),
              span(classes: 'font-body-sm text-[11px] text-outline', [Component.text('مقارنة بالشهر الماضي')]),
            ]),
          ]),
        ],
      ),

      // Metric 2: Total Orders
      div(
        classes:
            'bg-surface-container-lowest p-space-lg rounded-2xl shadow-[0_4px_20px_-2px_rgba(15,23,42,0.06)] border border-surface-container-high/40 flex flex-col justify-between hover:shadow-lg transition-shadow',
        [
          div(classes: 'flex items-center justify-between mb-3', [
            span(classes: 'font-label-md text-label-md text-outline', [Component.text('إجمالي الطلبات')]),
            div(classes: 'w-10 h-10 rounded-xl bg-surface-container text-surface-tint flex items-center justify-center', [
              span(
                classes: 'material-symbols-outlined text-[22px]',
                attributes: {'data-icon': 'shopping_basket'},
                [Component.text('shopping_basket')],
              ),
            ]),
          ]),
          div([
            div(classes: 'flex items-baseline gap-1', [
              span(classes: 'font-price-lg text-headline-md font-extrabold text-on-surface', [
                Component.text('1,420'),
              ]),
              span(classes: 'font-label-sm text-label-sm text-outline', [Component.text('طلب')]),
            ]),
            div(classes: 'flex items-center gap-1.5 mt-2', [
              span(
                classes:
                    'inline-flex items-center text-emerald-600 bg-emerald-50 px-1.5 py-0.5 rounded font-label-sm text-label-sm font-bold',
                [
                  span(
                    classes: 'material-symbols-outlined text-[14px]',
                    attributes: {'data-icon': 'arrow_upward'},
                    [Component.text('arrow_upward')],
                  ),
                  Component.text(' +12.2%'),
                ],
              ),
              span(classes: 'font-body-sm text-[11px] text-outline', [Component.text('خلال هذا الأسبوع')]),
            ]),
          ]),
        ],
      ),

      // Metric 3: Average Order Value
      div(
        classes:
            'bg-surface-container-lowest p-space-lg rounded-2xl shadow-[0_4px_20px_-2px_rgba(15,23,42,0.06)] border border-surface-container-high/40 flex flex-col justify-between hover:shadow-lg transition-shadow',
        [
          div(classes: 'flex items-center justify-between mb-3', [
            span(classes: 'font-label-md text-label-md text-outline', [Component.text('متوسط قيمة الطلب')]),
            div(classes: 'w-10 h-10 rounded-xl bg-surface-variant/70 text-on-surface-variant flex items-center justify-center', [
              span(
                classes: 'material-symbols-outlined text-[22px]',
                attributes: {'data-icon': 'receipt_long'},
                [Component.text('receipt_long')],
              ),
            ]),
          ]),
          div([
            div(classes: 'flex items-baseline gap-1', [
              span(classes: 'font-price-lg text-headline-md font-extrabold text-on-surface', [
                Component.text('385'),
              ]),
              span(classes: 'font-label-sm text-label-sm text-outline', [Component.text('ر.س')]),
            ]),
            div(classes: 'flex items-center gap-1.5 mt-2', [
              span(
                classes:
                    'inline-flex items-center text-emerald-600 bg-emerald-50 px-1.5 py-0.5 rounded font-label-sm text-label-sm font-bold',
                [
                  span(
                    classes: 'material-symbols-outlined text-[14px]',
                    attributes: {'data-icon': 'arrow_upward'},
                    [Component.text('arrow_upward')],
                  ),
                  Component.text(' +5.1%'),
                ],
              ),
              span(classes: 'font-body-sm text-[11px] text-outline', [Component.text('نمو إيجابي مستقر')]),
            ]),
          ]),
        ],
      ),

      // Metric 4: Active Customers
      div(
        classes:
            'bg-surface-container-lowest p-space-lg rounded-2xl shadow-[0_4px_20px_-2px_rgba(15,23,42,0.06)] border border-surface-container-high/40 flex flex-col justify-between hover:shadow-lg transition-shadow',
        [
          div(classes: 'flex items-center justify-between mb-3', [
            span(classes: 'font-label-md text-label-md text-outline', [Component.text('العملاء النشطون')]),
            div(classes: 'w-10 h-10 rounded-xl bg-surface-container-high text-primary flex items-center justify-center', [
              span(
                classes: 'material-symbols-outlined text-[22px]',
                attributes: {'data-icon': 'person_add'},
                [Component.text('person_add')],
              ),
            ]),
          ]),
          div([
            div(classes: 'flex items-baseline gap-1', [
              span(classes: 'font-price-lg text-headline-md font-extrabold text-on-surface', [
                Component.text('892'),
              ]),
              span(classes: 'font-label-sm text-label-sm text-outline', [Component.text('عميل')]),
            ]),
            div(classes: 'flex items-center gap-1.5 mt-2', [
              span(
                classes:
                    'inline-flex items-center text-primary bg-primary-fixed/40 px-1.5 py-0.5 rounded font-label-sm text-label-sm font-bold',
                [Component.text('+24')],
              ),
              span(classes: 'font-body-sm text-[11px] text-outline', [Component.text('عميل جديد اليوم')]),
            ]),
          ]),
        ],
      ),

      // Metric 5: Low Stock Alert
      div(
        classes:
            'bg-surface-container-lowest p-space-lg rounded-2xl shadow-[0_4px_20px_-2px_rgba(15,23,42,0.06)] border border-secondary-container/40 flex flex-col justify-between hover:shadow-lg transition-shadow',
        [
          div(classes: 'flex items-center justify-between mb-3', [
            span(classes: 'font-label-md text-label-md text-secondary', [Component.text('تنبيه المخزون المنخفض')]),
            div(classes: 'w-10 h-10 rounded-xl bg-secondary-fixed/50 text-secondary flex items-center justify-center', [
              span(
                classes: 'material-symbols-outlined text-[22px]',
                attributes: {'data-icon': 'warning'},
                [Component.text('warning')],
              ),
            ]),
          ]),
          div([
            div(classes: 'flex items-baseline gap-1', [
              span(classes: 'font-price-lg text-headline-md font-extrabold text-secondary', [
                Component.text('6'),
              ]),
              span(classes: 'font-label-sm text-label-sm text-outline', [Component.text('منتجات')]),
            ]),
            div(classes: 'flex items-center gap-1.5 mt-2', [
              span(
                classes:
                    'inline-flex items-center text-on-secondary-container bg-secondary-fixed px-1.5 py-0.5 rounded font-label-sm text-label-sm font-bold',
                [Component.text('إجراء مطلوب')],
              ),
              span(classes: 'font-body-sm text-[11px] text-outline', [Component.text('تحتاج لإعادة توريد')]),
            ]),
          ]),
        ],
      ),
    ]);
  }
}
