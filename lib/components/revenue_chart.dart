import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class RevenueChart extends StatelessComponent {
  const RevenueChart({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      classes:
          'lg:col-span-2 bg-surface-container-lowest p-space-xl rounded-2xl shadow-[0_4px_20px_-2px_rgba(15,23,42,0.06)] border border-surface-container-high/40 flex flex-col justify-between',
      [
        // Chart Header
        div(classes: 'flex flex-wrap items-center justify-between gap-4 mb-6', [
          div([
            div(classes: 'flex items-center gap-2', [
              span(classes: 'w-2.5 h-2.5 rounded-full bg-primary', []),
              h2(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface', [
                Component.text('تحليل وتطور الإيرادات والمبيعات'),
              ]),
            ]),
            p(classes: 'font-body-sm text-body-sm text-outline mt-1', [
              Component.text('مقارنة الإيرادات الفعلية مع المستهدف الشهري (2025)'),
            ]),
          ]),
          div(classes: 'flex items-center gap-4', [
            div(classes: 'flex items-center gap-2 text-on-surface font-label-sm text-label-sm', [
              span(classes: 'w-3 h-3 rounded-full bg-primary', []),
              span([Component.text('المبيعات الفعلية')]),
            ]),
            div(classes: 'flex items-center gap-2 text-outline font-label-sm text-label-sm', [
              span(classes: 'w-3 h-3 rounded-full bg-surface-container-high', []),
              span([Component.text('الهدف المحدد')]),
            ]),
            button(
              classes: 'text-outline hover:text-primary p-1.5 rounded-lg bg-surface-container-low transition-colors',
              [
                span(
                  classes: 'material-symbols-outlined text-[18px]',
                  attributes: {'data-icon': 'more_vert'},
                  [Component.text('more_vert')],
                ),
              ],
            ),
          ]),
        ]),

        // Custom Vector Graphic Chart Simulation
        div(classes: 'relative w-full h-64 pt-4 flex flex-col justify-between', [
          // Grid Lines
          div(classes: 'absolute inset-0 flex flex-col justify-between pointer-events-none opacity-40', [
            div(classes: 'w-full border-b border-dashed border-surface-container-high flex justify-end text-[10px] text-outline font-price-sm', [
              Component.text('60,000 ر.س'),
            ]),
            div(classes: 'w-full border-b border-dashed border-surface-container-high flex justify-end text-[10px] text-outline font-price-sm', [
              Component.text('45,000 ر.س'),
            ]),
            div(classes: 'w-full border-b border-dashed border-surface-container-high flex justify-end text-[10px] text-outline font-price-sm', [
              Component.text('30,000 ر.س'),
            ]),
            div(classes: 'w-full border-b border-dashed border-surface-container-high flex justify-end text-[10px] text-outline font-price-sm', [
              Component.text('15,000 ر.س'),
            ]),
            div(classes: 'w-full border-b border-surface-container-high', []),
          ]),

          // SVG Curves & Gradients
          div(classes: 'relative w-full h-52 z-10', [
            svg(
              classes: 'w-full h-full overflow-visible',
              viewBox: '0 0 700 180',
              attributes: {'preserveAspectRatio': 'none'},
              [
                Component.element(tag: 'defs', children: [
                  Component.element(
                    tag: 'linearGradient',
                    attributes: {'id': 'primaryGradient', 'x1': '0', 'x2': '0', 'y1': '0', 'y2': '1'},
                    children: [
                      Component.element(tag: 'stop', attributes: {'offset': '0%', 'stop-color': '#4f46e5', 'stop-opacity': '0.32'}),
                      Component.element(tag: 'stop', attributes: {'offset': '100%', 'stop-color': '#4f46e5', 'stop-opacity': '0.0'}),
                    ],
                  ),
                ]),
                // Target Dash Line
                path(
                  d: 'M 0,110 C 100,100 200,90 300,85 C 400,80 500,75 700,65',
                  attributes: {'fill': 'none', 'stroke': '#dae2fd', 'stroke-dasharray': '6 6', 'stroke-width': '2.5'},
                  [],
                ),
                // Main Area Fill
                path(
                  d: 'M 0,130 C 90,140 180,95 270,75 C 360,55 450,85 540,40 C 620,10 660,25 700,20 L 700,180 L 0,180 Z',
                  attributes: {'fill': 'url(#primaryGradient)'},
                  [],
                ),
                // Main Trend Line
                path(
                  d: 'M 0,130 C 90,140 180,95 270,75 C 360,55 450,85 540,40 C 620,10 660,25 700,20',
                  attributes: {'fill': 'none', 'stroke': '#4f46e5', 'stroke-linecap': 'round', 'stroke-width': '3.5'},
                  [],
                ),
                // Key Data Points
                circle(cx: '270', cy: '75', r: '4.5', attributes: {'fill': '#ffffff', 'stroke': '#4f46e5', 'stroke-width': '3'}, []),
                circle(cx: '540', cy: '40', r: '4.5', attributes: {'fill': '#ffffff', 'stroke': '#4f46e5', 'stroke-width': '3'}, []),
                circle(cx: '700', cy: '20', r: '6', attributes: {'fill': '#3525cd', 'stroke': '#ffffff', 'stroke-width': '2.5'}, []),
              ],
            ),
          ]),

          // Month Labels on Axis
          div(classes: 'flex justify-between items-center text-outline font-label-md text-label-sm pt-2 border-t border-surface-container', [
            span([Component.text('يناير')]),
            span([Component.text('فبراير')]),
            span([Component.text('مارس')]),
            span([Component.text('أبريل')]),
            span(classes: 'text-primary font-bold bg-primary-fixed/40 px-2 py-0.5 rounded-full', [
              Component.text('مايو (الحالي)'),
            ]),
            span([Component.text('يونيو')]),
            span([Component.text('يوليو')]),
          ]),
        ]),

        // Bottom Summary Highlights
        div(classes: 'grid grid-cols-3 gap-4 pt-6 mt-4 border-t border-surface-container-high/40 text-center', [
          div([
            span(classes: 'font-body-sm text-body-sm text-outline block', [Component.text('أعلى يوم مبيعاً')]),
            span(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface', [
              Component.text('الخميس (24,800 ر.س)'),
            ]),
          ]),
          div([
            span(classes: 'font-body-sm text-body-sm text-outline block', [Component.text('نسبة تحقيق الهدف')]),
            span(classes: 'font-headline-sm text-headline-sm font-bold text-emerald-600', [
              Component.text('92.4%'),
            ]),
          ]),
          div([
            span(classes: 'font-body-sm text-body-sm text-outline block', [Component.text('التحويل من الإعلانات')]),
            span(classes: 'font-headline-sm text-headline-sm font-bold text-primary', [
              Component.text('4.8%'),
            ]),
          ]),
        ]),
      ],
    );
  }
}
