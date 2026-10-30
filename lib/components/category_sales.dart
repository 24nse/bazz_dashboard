import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class CategorySales extends StatelessComponent {
  const CategorySales({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      classes:
          'bg-surface-container-lowest p-space-xl rounded-2xl shadow-[0_4px_20px_-2px_rgba(15,23,42,0.06)] border border-surface-container-high/40 flex flex-col justify-between',
      [
        div([
          div(classes: 'flex items-center justify-between mb-4', [
            h2(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface', [
              Component.text('مبيعات الفئات والتصنيفات'),
            ]),
            span(classes: 'font-label-sm text-label-sm text-outline bg-surface-container-low px-2 py-1 rounded-md', [
              Component.text('هذا الشهر'),
            ]),
          ]),
          p(classes: 'font-body-sm text-body-sm text-outline mb-6', [
            Component.text('نسبة مساهمة كل قسم في إجمالي المبيعات المحققة.'),
          ]),

          // Donut Simulation Visual
          div(classes: 'flex items-center justify-center relative py-2', [
            div(
              classes:
                  'w-40 h-40 rounded-full border-[14px] border-primary flex items-center justify-center relative border-t-amber-500 border-l-rose-500 border-b-indigo-300',
              [
                div(classes: 'flex flex-col items-center', [
                  span(classes: 'font-label-sm text-label-sm text-outline', [Component.text('الأعلى مبيعاً')]),
                  span(classes: 'font-price-lg text-headline-md font-extrabold text-on-surface', [
                    Component.text('42%'),
                  ]),
                  span(classes: 'font-label-sm text-label-sm text-primary font-bold', [
                    Component.text('أحذية رياضية'),
                  ]),
                ]),
              ],
            ),
          ]),
        ]),

        // Category Percent Breakdown List
        div(classes: 'space-y-3 pt-6 border-t border-surface-container-high/40', [
          // Category 1
          div(classes: 'flex items-center justify-between', [
            div(classes: 'flex items-center gap-2.5', [
              span(classes: 'w-3 h-3 rounded-full bg-primary', []),
              span(classes: 'font-label-md text-label-md text-on-surface font-semibold', [
                Component.text('أحذية وسنيكرز رياضية'),
              ]),
            ]),
            div(classes: 'flex items-center gap-2', [
              span(classes: 'font-price-sm text-label-md font-bold text-on-surface', [Component.text('42%')]),
              span(classes: 'text-outline font-label-sm text-label-sm', [Component.text('(62,546 ر.س)')]),
            ]),
          ]),

          // Category 2
          div(classes: 'flex items-center justify-between', [
            div(classes: 'flex items-center gap-2.5', [
              span(classes: 'w-3 h-3 rounded-full bg-amber-500', []),
              span(classes: 'font-label-md text-label-md text-on-surface font-semibold', [
                Component.text('إلكترونيات وسماعات'),
              ]),
            ]),
            div(classes: 'flex items-center gap-2', [
              span(classes: 'font-price-sm text-label-md font-bold text-on-surface', [Component.text('28%')]),
              span(classes: 'text-outline font-label-sm text-label-sm', [Component.text('(41,697 ر.س)')]),
            ]),
          ]),

          // Category 3
          div(classes: 'flex items-center justify-between', [
            div(classes: 'flex items-center gap-2.5', [
              span(classes: 'w-3 h-3 rounded-full bg-rose-500', []),
              span(classes: 'font-label-md text-label-md text-on-surface font-semibold', [
                Component.text('أزياء وملابس شبابية'),
              ]),
            ]),
            div(classes: 'flex items-center gap-2', [
              span(classes: 'font-price-sm text-label-md font-bold text-on-surface', [Component.text('18%')]),
              span(classes: 'text-outline font-label-sm text-label-sm', [Component.text('(26,805 ر.س)')]),
            ]),
          ]),

          // Category 4
          div(classes: 'flex items-center justify-between', [
            div(classes: 'flex items-center gap-2.5', [
              span(classes: 'w-3 h-3 rounded-full bg-indigo-300', []),
              span(classes: 'font-label-md text-label-md text-on-surface font-semibold', [
                Component.text('إكسسوارات وساعات'),
              ]),
            ]),
            div(classes: 'flex items-center gap-2', [
              span(classes: 'font-price-sm text-label-md font-bold text-on-surface', [Component.text('12%')]),
              span(classes: 'text-outline font-label-sm text-label-sm', [Component.text('(17,872 ر.س)')]),
            ]),
          ]),
        ]),
      ],
    );
  }
}
