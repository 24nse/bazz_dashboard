import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class TopProducts extends StatelessComponent {
  const TopProducts({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      classes:
          'bg-surface-container-lowest p-space-lg rounded-2xl shadow-[0_4px_20px_-2px_rgba(15,23,42,0.06)] border border-surface-container-high/40',
      [
        div(classes: 'flex items-center justify-between mb-4', [
          h3(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface', [
            Component.text('الأكثر مبيعاً'),
          ]),
          a(classes: 'font-label-sm text-label-sm text-primary font-bold hover:underline', href: '#', [
            Component.text('التقرير الكامل'),
          ]),
        ]),
        div(classes: 'space-y-3.5', [
          // Product 1
          div(classes: 'flex items-center justify-between p-2 rounded-xl hover:bg-surface-container-low transition-colors', [
            div(classes: 'flex items-center gap-3', [
              div(classes: 'w-12 h-12 rounded-xl bg-surface-container-low p-1.5 flex-shrink-0 flex items-center justify-center overflow-hidden border border-surface-container', [
                img(
                  classes: 'w-full h-full object-contain',
                  src:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBkOwS5BpW80H-NHhqc83STQmGm2uu4iafc-16QQ0ZM0qC6x1_2NDpWGXpM6c33DM320KTiu0UzsGWMbpgj-Qtk_6NjEyt0rcyie9pJTQbMJoasmjM4E7Ppd_Gggu-hldv48akNM-IopvFyC3icbliNd925h_8TQWDo8CcnNkhhHc28oyqK5CbEyvmbYTgp_cQSjyqVoPpgZBqqvPAXnIFemDzSxAqgVsDFoD3syK7Jph3f0rYBbFi5',
                  alt: 'Nike Sneaker',
                ),
              ]),
              div([
                h4(classes: 'font-label-md text-label-md font-bold text-on-surface leading-snug', [
                  Component.text('نايكي إير ماكس بلس'),
                ]),
                span(classes: 'text-outline font-label-sm text-[11px]', [
                  Component.text('تم بيع 184 قطعة • المخزون: 42'),
                ]),
              ]),
            ]),
            div(classes: 'text-left font-price-sm', [
              span(classes: 'font-bold text-on-surface block text-label-md', [Component.text('649 ر.س')]),
              span(classes: 'text-emerald-600 text-[11px] font-bold', [Component.text('+28%')]),
            ]),
          ]),

          // Product 2
          div(classes: 'flex items-center justify-between p-2 rounded-xl hover:bg-surface-container-low transition-colors', [
            div(classes: 'flex items-center gap-3', [
              div(classes: 'w-12 h-12 rounded-xl bg-surface-container-low p-1.5 flex-shrink-0 flex items-center justify-center overflow-hidden border border-surface-container', [
                img(
                  classes: 'w-full h-full object-contain',
                  src:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBB8owUe1GOZ3y-fiNi_a5elBttQ5rTYnIKRuk7XAL5Mma3nqiOB_c1xWHAM7M3CjMe1693Q8Uo6a1qSAlA8WMTfMLdVxoqUncXmBkgcze3csUsQs-X2iQCRb_taXea3evqiVjPOHHelc5-LLKrJz2U8apaViNfwqZ4YcYIpLEAM0315bo0VMonVkNXtfvGleu8IKz2OcDsCai4dPCyuWSZ5wNwmqumUlMeBU8VQ2TEtRhlNKlvjdzF',
                  alt: 'Sony Headphones',
                ),
              ]),
              div([
                h4(classes: 'font-label-md text-label-md font-bold text-on-surface leading-snug', [
                  Component.text('سماعات سوني WH-1000XM5'),
                ]),
                span(classes: 'text-outline font-label-sm text-[11px]', [
                  Component.text('تم بيع 129 قطعة • المخزون: 18'),
                ]),
              ]),
            ]),
            div(classes: 'text-left font-price-sm', [
              span(classes: 'font-bold text-on-surface block text-label-md', [Component.text('1,120 ر.س')]),
              span(classes: 'text-emerald-600 text-[11px] font-bold', [Component.text('+19%')]),
            ]),
          ]),

          // Product 3
          div(classes: 'flex items-center justify-between p-2 rounded-xl hover:bg-surface-container-low transition-colors', [
            div(classes: 'flex items-center gap-3', [
              div(classes: 'w-12 h-12 rounded-xl bg-surface-container-low p-1.5 flex-shrink-0 flex items-center justify-center overflow-hidden border border-surface-container', [
                img(
                  classes: 'w-full h-full object-contain',
                  src:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuDL3rhUiX8SLJKcn4_6y2Axfcx1jnL3SutIpRHR7ih9z3hrdrlCS0l9504diCNVNR47F6ChWQjDDVf5nx2PPxp2yuPTU-qGSeh1lyE9HMcxPaoxB_8HVoXMRKMTD8hstpQTd_yVwOV1ZVltO6M_MSZsgo-c18LnOX3zWbGS1cIVlGFldQudQVec6oJ4D6vBmaHJDhqtf_y3hT34i6-mjBRxLqM9-lKYoVrnqpgfVm24OlTHjovavG9w',
                  alt: 'Apple Watch',
                ),
              ]),
              div([
                h4(classes: 'font-label-md text-label-md font-bold text-on-surface leading-snug', [
                  Component.text('ساعة آبل الذكية الجيل 9'),
                ]),
                span(classes: 'text-outline font-label-sm text-[11px]', [
                  Component.text('تم بيع 94 قطعة • المخزون: 6 (منخفض)'),
                ]),
              ]),
            ]),
            div(classes: 'text-left font-price-sm', [
              span(classes: 'font-bold text-on-surface block text-label-md', [Component.text('1,890 ر.س')]),
              span(classes: 'text-emerald-600 text-[11px] font-bold', [Component.text('+12%')]),
            ]),
          ]),
        ]),
      ],
    );
  }
}
