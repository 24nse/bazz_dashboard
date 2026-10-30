import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class RecentOrders extends StatelessComponent {
  const RecentOrders({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      classes:
          'lg:col-span-2 bg-surface-container-lowest rounded-2xl shadow-[0_4px_20px_-2px_rgba(15,23,42,0.06)] border border-surface-container-high/40 overflow-hidden',
      [
        // Table Header & Filters
        div(classes: 'p-space-lg border-b border-surface-container-high/40 flex flex-wrap items-center justify-between gap-4', [
          div([
            h2(classes: 'font-headline-sm text-headline-sm font-bold text-on-surface', [
              Component.text('أحدث الطلبات المستلمة'),
            ]),
            p(classes: 'font-body-sm text-body-sm text-outline', [
              Component.text('تحديث فوري للطلبات الواردة من تطبيق المتجر'),
            ]),
          ]),
          div(classes: 'flex items-center gap-2', [
            div(classes: 'flex items-center bg-surface-container-low p-1 rounded-xl text-on-surface-variant text-label-sm font-label-sm font-bold', [
              button(classes: 'px-2.5 py-1 rounded-lg bg-surface-container-lowest text-primary shadow-sm', [
                Component.text('الكل'),
              ]),
              button(classes: 'px-2.5 py-1 rounded-lg hover:text-primary', [
                Component.text('قيد التجهيز'),
              ]),
              button(classes: 'px-2.5 py-1 rounded-lg hover:text-primary', [
                Component.text('تم الشحن'),
              ]),
              button(classes: 'px-2.5 py-1 rounded-lg hover:text-primary', [
                Component.text('مكتمل'),
              ]),
            ]),
            a(classes: 'font-label-md text-label-md text-primary font-bold hover:underline px-2 py-1', href: '#', [
              Component.text('عرض جميع الطلبات'),
            ]),
          ]),
        ]),

        // Orders Table Container
        div(classes: 'overflow-x-auto', [
          table(classes: 'w-full text-right border-collapse', [
            thead([
              tr(classes: 'bg-surface-container-low/50 border-b border-surface-container-high/40 text-outline font-label-sm text-label-sm uppercase', [
                th(classes: 'py-3.5 px-space-lg', [Component.text('رقم الطلب')]),
                th(classes: 'py-3.5 px-space-md', [Component.text('العميل')]),
                th(classes: 'py-3.5 px-space-md', [Component.text('التاريخ والوقت')]),
                th(classes: 'py-3.5 px-space-md', [Component.text('المنتجات')]),
                th(classes: 'py-3.5 px-space-md', [Component.text('الإجمالي')]),
                th(classes: 'py-3.5 px-space-md', [Component.text('الحالة')]),
                th(classes: 'py-3.5 px-space-lg text-center', [Component.text('الإجراءات')]),
              ]),
            ]),
            tbody(classes: 'divide-y divide-surface-container-high/30 font-body-sm text-body-sm', [
              // Order Row 1
              tr(classes: 'hover:bg-surface-container-low/40 transition-colors', [
                td(classes: 'py-3.5 px-space-lg font-bold font-price-sm text-primary', [
                  Component.text('#FLT-89432'),
                ]),
                td(classes: 'py-3.5 px-space-md', [
                  div(classes: 'flex items-center gap-2.5', [
                    div(classes: 'w-8 h-8 rounded-full bg-surface-container flex items-center justify-center font-bold text-primary overflow-hidden', [
                      img(
                        classes: 'w-full h-full object-cover',
                        src:
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuBU3h17kdyMxqHnMiQSe0I-aE5gCPTMX_5rqBxqWRaZYs8BrM0Fm4uFPvZ2fwNk4HpS0wYF-OZshvpvp-7s9aNIZu_m7km1cREwlQqjnvNiEA-ivh35aVpM-ah95HZSwpiqkokiLIuzmPkokMLykp78qn3g5d6bETjcK1jsata5P8ytwj0GVV7GvhoLnHxmA-h2ktvYo1Wcsf1GmWwOSuhb8ou8U5OoNwUydveLaGugn9VjhEOV-brH',
                        alt: 'Customer photo',
                      ),
                    ]),
                    div([
                      span(classes: 'font-label-md text-label-md font-bold text-on-surface block', [
                        Component.text('سعد الدوسري'),
                      ]),
                      span(classes: 'text-[11px] text-outline', [Component.text('الرياض، المملكة')]),
                    ]),
                  ]),
                ]),
                td(classes: 'py-3.5 px-space-md text-outline', [Component.text('منذ 14 دقيقة')]),
                td(classes: 'py-3.5 px-space-md text-on-surface font-semibold', [Component.text('حذاء نايكي + جورب')]),
                td(classes: 'py-3.5 px-space-md font-price-sm font-bold text-on-surface', [Component.text('649 ر.س')]),
                td(classes: 'py-3.5 px-space-md', [
                  span(
                    classes:
                        'inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full font-label-sm text-label-sm font-bold bg-amber-50 text-amber-700 border border-amber-200',
                    [
                      span(classes: 'w-1.5 h-1.5 rounded-full bg-amber-500', []),
                      Component.text('قيد التجهيز'),
                    ],
                  ),
                ]),
                td(classes: 'py-3.5 px-space-lg text-center', [
                  div(classes: 'flex items-center justify-center gap-1', [
                    button(
                      classes:
                          'p-1.5 rounded-lg text-outline hover:text-primary hover:bg-surface-container transition-colors',
                      attributes: {'title': 'تفاصيل الطلب'},
                      [
                        span(
                          classes: 'material-symbols-outlined text-[18px]',
                          attributes: {'data-icon': 'visibility'},
                          [Component.text('visibility')],
                        ),
                      ],
                    ),
                    button(
                      classes:
                          'p-1.5 rounded-lg text-outline hover:text-primary hover:bg-surface-container transition-colors',
                      attributes: {'title': 'طباعة الفاتورة'},
                      [
                        span(
                          classes: 'material-symbols-outlined text-[18px]',
                          attributes: {'data-icon': 'print'},
                          [Component.text('print')],
                        ),
                      ],
                    ),
                  ]),
                ]),
              ]),

              // Order Row 2
              tr(classes: 'hover:bg-surface-container-low/40 transition-colors', [
                td(classes: 'py-3.5 px-space-lg font-bold font-price-sm text-primary', [
                  Component.text('#FLT-89431'),
                ]),
                td(classes: 'py-3.5 px-space-md', [
                  div(classes: 'flex items-center gap-2.5', [
                    div(classes: 'w-8 h-8 rounded-full bg-surface-container flex items-center justify-center font-bold text-primary overflow-hidden', [
                      img(
                        classes: 'w-full h-full object-cover',
                        src:
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuDrV2wgS-7xvAp1YmLACSSspxNqfGG2S1p-LiyrO-w0S6n27guHAlWnQffuVZ6GBbcZ3R7-5wqKHB-iKGy4IeeUA_yruCcGrF67rWxZaRCDMeM7SIR81atIzWuBn4olTUobXiCOPsi7LxicTG6e8_GtKEMGHYsVUHLN5weWR_r5BZR2-FBZL4p98jaMlX_IOyWIsRDtFH6p5HhRxu7PHAlK8OpoNuYokpO6juHFnvUJnwzdTcsh0WWc',
                        alt: 'Customer photo',
                      ),
                    ]),
                    div([
                      span(classes: 'font-label-md text-label-md font-bold text-on-surface block', [
                        Component.text('ريم العتيبي'),
                      ]),
                      span(classes: 'text-[11px] text-outline', [Component.text('جدة، المملكة')]),
                    ]),
                  ]),
                ]),
                td(classes: 'py-3.5 px-space-md text-outline', [Component.text('منذ 42 دقيقة')]),
                td(classes: 'py-3.5 px-space-md text-on-surface font-semibold', [Component.text('سماعات سوني اللاسلكية')]),
                td(classes: 'py-3.5 px-space-md font-price-sm font-bold text-on-surface', [Component.text('1,120 ر.س')]),
                td(classes: 'py-3.5 px-space-md', [
                  span(
                    classes:
                        'inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full font-label-sm text-label-sm font-bold bg-indigo-50 text-indigo-700 border border-indigo-200',
                    [
                      span(classes: 'w-1.5 h-1.5 rounded-full bg-primary', []),
                      Component.text('تم الشحن'),
                    ],
                  ),
                ]),
                td(classes: 'py-3.5 px-space-lg text-center', [
                  div(classes: 'flex items-center justify-center gap-1', [
                    button(
                      classes:
                          'p-1.5 rounded-lg text-outline hover:text-primary hover:bg-surface-container transition-colors',
                      attributes: {'title': 'تفاصيل الطلب'},
                      [
                        span(
                          classes: 'material-symbols-outlined text-[18px]',
                          attributes: {'data-icon': 'visibility'},
                          [Component.text('visibility')],
                        ),
                      ],
                    ),
                    button(
                      classes:
                          'p-1.5 rounded-lg text-outline hover:text-primary hover:bg-surface-container transition-colors',
                      attributes: {'title': 'طباعة الفاتورة'},
                      [
                        span(
                          classes: 'material-symbols-outlined text-[18px]',
                          attributes: {'data-icon': 'print'},
                          [Component.text('print')],
                        ),
                      ],
                    ),
                  ]),
                ]),
              ]),

              // Order Row 3
              tr(classes: 'hover:bg-surface-container-low/40 transition-colors', [
                td(classes: 'py-3.5 px-space-lg font-bold font-price-sm text-primary', [
                  Component.text('#FLT-89430'),
                ]),
                td(classes: 'py-3.5 px-space-md', [
                  div(classes: 'flex items-center gap-2.5', [
                    div(classes: 'w-8 h-8 rounded-full bg-surface-container flex items-center justify-center font-bold text-primary overflow-hidden', [
                      img(
                        classes: 'w-full h-full object-cover',
                        src:
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuBejJEAp2urB1vbTUCIieAWc6K7FCFGYEo2hbV_SoqSohajD_-oKqZALHvxxrLEq1I54cp3_fnm-wUagbVnrMuTg355_vSMLGuPXnosSAp6UWkd1HObA5q58mVYoyenKgOICPiQoZ4-wftIISyePbLruONouJK-ASsrMZ53pF_I6FdagxencMji9sFP17-2GEAXEa0FmU3d-vHdPcFpBk3PhS8d6L4wWEEdYaCR4ZAoGbIDfuO4dbBg',
                        alt: 'Customer photo',
                      ),
                    ]),
                    div([
                      span(classes: 'font-label-md text-label-md font-bold text-on-surface block', [
                        Component.text('فيصل الشمري'),
                      ]),
                      span(classes: 'text-[11px] text-outline', [Component.text('الدمام، المملكة')]),
                    ]),
                  ]),
                ]),
                td(classes: 'py-3.5 px-space-md text-outline', [Component.text('منذ ساعتين')]),
                td(classes: 'py-3.5 px-space-md text-on-surface font-semibold', [Component.text('ساعة أبل الجيل التاسع')]),
                td(classes: 'py-3.5 px-space-md font-price-sm font-bold text-on-surface', [Component.text('1,890 ر.س')]),
                td(classes: 'py-3.5 px-space-md', [
                  span(
                    classes:
                        'inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full font-label-sm text-label-sm font-bold bg-emerald-50 text-emerald-700 border border-emerald-200',
                    [
                      span(classes: 'w-1.5 h-1.5 rounded-full bg-emerald-500', []),
                      Component.text('مكتمل ومستلم'),
                    ],
                  ),
                ]),
                td(classes: 'py-3.5 px-space-lg text-center', [
                  div(classes: 'flex items-center justify-center gap-1', [
                    button(
                      classes:
                          'p-1.5 rounded-lg text-outline hover:text-primary hover:bg-surface-container transition-colors',
                      attributes: {'title': 'تفاصيل الطلب'},
                      [
                        span(
                          classes: 'material-symbols-outlined text-[18px]',
                          attributes: {'data-icon': 'visibility'},
                          [Component.text('visibility')],
                        ),
                      ],
                    ),
                    button(
                      classes:
                          'p-1.5 rounded-lg text-outline hover:text-primary hover:bg-surface-container transition-colors',
                      attributes: {'title': 'طباعة الفاتورة'},
                      [
                        span(
                          classes: 'material-symbols-outlined text-[18px]',
                          attributes: {'data-icon': 'print'},
                          [Component.text('print')],
                        ),
                      ],
                    ),
                  ]),
                ]),
              ]),

              // Order Row 4
              tr(classes: 'hover:bg-surface-container-low/40 transition-colors', [
                td(classes: 'py-3.5 px-space-lg font-bold font-price-sm text-primary', [
                  Component.text('#FLT-89429'),
                ]),
                td(classes: 'py-3.5 px-space-md', [
                  div(classes: 'flex items-center gap-2.5', [
                    div(classes: 'w-8 h-8 rounded-full bg-surface-container flex items-center justify-center font-bold text-primary overflow-hidden', [
                      img(
                        classes: 'w-full h-full object-cover',
                        src:
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuCdA3t2sMfg3KN2aOwImegZoZhy2tAdJ3ZIImGX89fjv-R70MNpL7MIwjnQlTPxSJoNlKdAE3K5ejWXqOP2wNqAIhuEvNKogJ9_OveXNPHeSsatzCd359sbNmMHKHf70Xm2LmpyapPFDM7iaCQE7Ul0HvcobeZpjHbNg0BAcuHSBTbcoIEr7iS2hZoUit-8Cmg4ba-t4ywXhqGyIUh9ECNCEtssMhqviWfMk0uv05angVOqjpQdjKMi',
                        alt: 'Customer photo',
                      ),
                    ]),
                    div([
                      span(classes: 'font-label-md text-label-md font-bold text-on-surface block', [
                        Component.text('نوف القحطاني'),
                      ]),
                      span(classes: 'text-[11px] text-outline', [Component.text('أبها، المملكة')]),
                    ]),
                  ]),
                ]),
                td(classes: 'py-3.5 px-space-md text-outline', [Component.text('منذ 3 ساعات')]),
                td(classes: 'py-3.5 px-space-md text-on-surface font-semibold', [Component.text('حقيبة ظهر جلدية فاخرة')]),
                td(classes: 'py-3.5 px-space-md font-price-sm font-bold text-on-surface', [Component.text('320 ر.س')]),
                td(classes: 'py-3.5 px-space-md', [
                  span(
                    classes:
                        'inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full font-label-sm text-label-sm font-bold bg-blue-50 text-blue-700 border border-blue-200',
                    [
                      span(classes: 'w-1.5 h-1.5 rounded-full bg-blue-500', []),
                      Component.text('مدفوع - ينتظر الشحن'),
                    ],
                  ),
                ]),
                td(classes: 'py-3.5 px-space-lg text-center', [
                  div(classes: 'flex items-center justify-center gap-1', [
                    button(
                      classes:
                          'p-1.5 rounded-lg text-outline hover:text-primary hover:bg-surface-container transition-colors',
                      attributes: {'title': 'تفاصيل الطلب'},
                      [
                        span(
                          classes: 'material-symbols-outlined text-[18px]',
                          attributes: {'data-icon': 'visibility'},
                          [Component.text('visibility')],
                        ),
                      ],
                    ),
                    button(
                      classes:
                          'p-1.5 rounded-lg text-outline hover:text-primary hover:bg-surface-container transition-colors',
                      attributes: {'title': 'طباعة الفاتورة'},
                      [
                        span(
                          classes: 'material-symbols-outlined text-[18px]',
                          attributes: {'data-icon': 'print'},
                          [Component.text('print')],
                        ),
                      ],
                    ),
                  ]),
                ]),
              ]),
            ]),
          ]),
        ]),

        // Table Footer Pagination Summary
        div(classes: 'p-space-md border-t border-surface-container-high/40 bg-surface-container-low/30 flex items-center justify-between', [
          span(classes: 'font-body-sm text-body-sm text-outline', [
            Component.text('عرض 4 من أصل 12 طلب جديد يتطلب التعامل السريع'),
          ]),
          div(classes: 'flex items-center gap-1', [
            button(classes: 'px-3 py-1 rounded-lg border border-surface-container bg-surface-container-lowest font-label-sm text-label-sm text-outline hover:text-primary transition-colors', [
              Component.text('السابق'),
            ]),
            button(classes: 'px-3 py-1 rounded-lg bg-primary text-on-primary font-label-sm text-label-sm font-bold', [
              Component.text('1'),
            ]),
            button(classes: 'px-3 py-1 rounded-lg border border-surface-container bg-surface-container-lowest font-label-sm text-label-sm text-outline hover:text-primary transition-colors', [
              Component.text('2'),
            ]),
            button(classes: 'px-3 py-1 rounded-lg border border-surface-container bg-surface-container-lowest font-label-sm text-label-sm text-outline hover:text-primary transition-colors', [
              Component.text('التالي'),
            ]),
          ]),
        ]),
      ],
    );
  }
}
