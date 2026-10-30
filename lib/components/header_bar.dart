import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class HeaderBar extends StatelessComponent {
  const HeaderBar({super.key});

  @override
  Component build(BuildContext context) {
    return header(
      classes:
          'bg-surface-container-lowest px-space-xl py-3.5 shadow-sm flex items-center justify-between z-20 flex-shrink-0',
      [
        // Greeting & Search Input
        div(classes: 'flex items-center gap-6', [
          div([
            h1(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface', [
              Component.text('مرحباً عبد الله 👋'),
            ]),
            p(classes: 'font-body-sm text-body-sm text-outline', [
              Component.text('الأربعاء، 15 مايو 2025 • نظرة تفاعلية للمبيعات'),
            ]),
          ]),

          // Global Search Bar
          div(classes: 'relative w-80 hidden lg:block', [
            span(
              classes:
                  'material-symbols-outlined absolute right-3.5 top-1/2 -translate-y-1/2 text-outline text-[20px]',
              attributes: {'data-icon': 'search'},
              [Component.text('search')],
            ),
            input(
              classes:
                  'w-full h-11 pr-11 pl-4 bg-surface-container-low rounded-full border-0 text-on-surface placeholder:text-outline font-body-sm text-body-sm focus:ring-2 focus:ring-primary focus:bg-surface-container-lowest transition-all',
              type: InputType.text,
              attributes: {'placeholder': 'ابحث برقم الطلب، اسم المنتج، العميل...'},
            ),
            span(
              classes:
                  'absolute left-3 top-1/2 -translate-y-1/2 font-label-sm text-label-sm text-outline bg-surface-container-lowest px-1.5 py-0.5 rounded border border-surface-container',
              [Component.text('⌘K')],
            ),
          ]),
        ]),

        // Actions & Date Range Controls
        div(classes: 'flex items-center gap-3', [
          // Date Selector Filter
          div(
            classes:
                'hidden sm:flex items-center gap-1 bg-surface-container-low p-1 rounded-full border border-surface-container',
            [
              button(
                classes:
                    'px-3 py-1.5 rounded-full font-label-sm text-label-sm font-bold bg-primary text-on-primary shadow-sm transition-all',
                [Component.text('اليوم')],
              ),
              button(
                classes:
                    'px-3 py-1.5 rounded-full font-label-sm text-label-sm text-outline hover:text-on-surface transition-all',
                [Component.text('آخر 7 أيام')],
              ),
              button(
                classes:
                    'px-3 py-1.5 rounded-full font-label-sm text-label-sm text-outline hover:text-on-surface transition-all',
                [Component.text('آخر 30 يوماً')],
              ),
              button(
                classes:
                    'px-3 py-1.5 rounded-full font-label-sm text-label-sm text-outline hover:text-on-surface transition-all',
                [Component.text('هذا العام')],
              ),
            ],
          ),

          div(classes: 'h-6 w-px bg-surface-container-high hidden sm:block', []),

          // Storefront Live Preview Icon Button
          a(
            classes:
                'w-11 h-11 rounded-full bg-surface-container-low text-on-surface-variant hover:text-primary hover:bg-surface-container flex items-center justify-center transition-colors',
            href: '#',
            target: Target.blank,
            attributes: {'title': 'معاينة المتجر المباشر'},
            [
              span(
                classes: 'material-symbols-outlined text-[20px]',
                attributes: {'data-icon': 'storefront'},
                [Component.text('storefront')],
              ),
            ],
          ),

          // Notifications with Badge
          div(classes: 'relative', [
            button(
              classes:
                  'w-11 h-11 rounded-full bg-surface-container-low text-on-surface-variant hover:text-primary hover:bg-surface-container flex items-center justify-center transition-colors',
              [
                span(
                  classes: 'material-symbols-outlined text-[22px]',
                  attributes: {'data-icon': 'notifications'},
                  [Component.text('notifications')],
                ),
              ],
            ),
            span(
              classes:
                  'absolute top-1 right-1 w-5 h-5 bg-error text-on-error font-label-sm text-[10px] font-bold rounded-full flex items-center justify-center ring-2 ring-surface-container-lowest',
              [Component.text('4')],
            ),
          ]),

          // Add New Product Button
          button(
            classes:
                'h-11 px-5 rounded-full bg-primary hover:bg-primary-container text-on-primary font-label-md text-label-md font-bold flex items-center gap-2 shadow-md shadow-primary/20 transition-all duration-150 active:scale-95',
            [
              span(
                classes: 'material-symbols-outlined text-[20px]',
                attributes: {'data-icon': 'add'},
                [Component.text('add')],
              ),
              span([Component.text('إضافة منتج جديد')]),
            ],
          ),
        ]),
      ],
    );
  }
}
