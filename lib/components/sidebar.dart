import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class Sidebar extends StatelessComponent {
  const Sidebar({super.key});

  @override
  Component build(BuildContext context) {
    return aside(
      classes:
          'w-72 bg-surface-container-lowest flex flex-col flex-shrink-0 z-30 shadow-[0_4px_20px_-2px_rgba(15,23,42,0.06)] border-l border-surface-container-high/40 select-none',
      [
        // Logo & Brand Header
        div(classes: 'px-space-lg py-5 flex items-center gap-3 border-b border-surface-container-high/30', [
          div(classes: 'w-11 h-11 rounded-xl bg-primary flex items-center justify-center text-on-primary shadow-md shadow-primary/20', [
            span(
              classes: 'material-symbols-outlined text-[24px]',
              attributes: {'data-icon': 'shopping_bag', 'style': "font-variation-settings: 'FILL' 1;"},
              [Component.text('shopping_bag')],
            ),
          ]),
          div(classes: 'flex flex-col', [
            div(classes: 'flex items-center gap-2', [
              span(classes: 'font-headline-md text-headline-sm text-on-surface font-bold tracking-tight', [
                Component.text('متجر نبض'),
              ]),
              span(classes: 'bg-primary/10 text-primary font-label-sm text-label-sm px-2 py-0.5 rounded-full font-bold', [
                Component.text('PRO'),
              ]),
            ]),
            span(classes: 'text-on-surface-variant font-label-sm text-label-sm', [
              Component.text('لوحة الإدارة الرئيسية'),
            ]),
          ]),
        ]),

        // Navigation Links
        div(classes: 'flex-1 overflow-y-auto custom-scroll px-space-md py-4 space-y-1', [
          div(classes: 'px-3 pb-2 pt-1 text-[11px] font-bold text-outline uppercase tracking-wider font-label-sm', [
            Component.text('نظرة عامة وإدارة المتجر'),
          ]),

          // Item: Dashboard
          a(
            classes:
                'flex items-center justify-between px-3.5 py-3 rounded-xl hover:bg-surface-container text-on-surface-variant font-medium transition-all duration-150',
            href: '/',
            [
              div(classes: 'flex items-center gap-3', [
                span(
                  classes: 'material-symbols-outlined text-[20px]',
                  attributes: {'data-icon': 'dashboard'},
                  [Component.text('dashboard')],
                ),
                span(classes: 'font-label-md text-label-md', [
                  Component.text('الرئيسية والإحصائيات'),
                ]),
              ]),
            ],
          ),

          // Item: Products & Inventory
          a(
            classes:
                'flex items-center justify-between px-3.5 py-3 rounded-xl text-on-surface-variant hover:bg-surface-container hover:text-primary transition-all duration-150 group',
            href: '/products',
            [
              div(classes: 'flex items-center gap-3', [
                span(
                  classes: 'material-symbols-outlined text-[20px] text-outline group-hover:text-primary transition-colors',
                  attributes: {'data-icon': 'inventory_2'},
                  [Component.text('inventory_2')],
                ),
                span(classes: 'font-label-md text-label-md', [
                  Component.text('المنتجات والمخزون'),
                ]),
              ]),
              span(
                classes:
                    'bg-surface-container-high text-on-surface-variant group-hover:bg-primary-fixed group-hover:text-primary font-label-sm text-label-sm px-2 py-0.5 rounded-full transition-colors',
                [Component.text('340')],
              ),
            ],
          ),

          // Item: Add Product Quick Sub-link
          a(
            classes:
                'flex items-center justify-between px-3 py-2 rounded-xl text-primary font-semibold bg-primary/5 hover:bg-primary/10 transition-all duration-150 mr-4',
            href: '/add-product',
            [
              div(classes: 'flex items-center gap-2', [
                span(
                  classes: 'material-symbols-outlined text-[18px]',
                  attributes: {'data-icon': 'add_circle'},
                  [Component.text('add_circle')],
                ),
                span(classes: 'font-label-sm text-label-sm', [
                  Component.text('إضافة منتج جديد +'),
                ]),
              ]),
              span(classes: 'text-[10px] bg-primary text-on-primary px-1.5 py-0.2 rounded font-bold', [
                Component.text('جديد'),
              ]),
            ],
          ),

          // Item: Orders
          a(
            classes:
                'flex items-center justify-between px-3.5 py-3 rounded-xl text-on-surface-variant hover:bg-surface-container hover:text-primary transition-all duration-150 group',
            href: '#',
            [
              div(classes: 'flex items-center gap-3', [
                span(
                  classes: 'material-symbols-outlined text-[20px] text-outline group-hover:text-primary transition-colors',
                  attributes: {'data-icon': 'local_shipping'},
                  [Component.text('local_shipping')],
                ),
                span(classes: 'font-label-md text-label-md', [
                  Component.text('الطلبات والشحنات'),
                ]),
              ]),
              span(
                classes:
                    'bg-secondary-container text-on-secondary-container font-label-sm text-label-sm px-2 py-0.5 rounded-full font-bold',
                [Component.text('12 جديد')],
              ),
            ],
          ),

          // Item: Categories
          a(
            classes:
                'flex items-center justify-between px-3.5 py-3 rounded-xl text-on-surface-variant hover:bg-surface-container hover:text-primary transition-all duration-150 group',
            href: '#',
            [
              div(classes: 'flex items-center gap-3', [
                span(
                  classes: 'material-symbols-outlined text-[20px] text-outline group-hover:text-primary transition-colors',
                  attributes: {'data-icon': 'category'},
                  [Component.text('category')],
                ),
                span(classes: 'font-label-md text-label-md', [
                  Component.text('الأقسام والتصنيفات'),
                ]),
              ]),
            ],
          ),

          // Item: Customers
          a(
            classes:
                'flex items-center justify-between px-3.5 py-3 rounded-xl text-on-surface-variant hover:bg-surface-container hover:text-primary transition-all duration-150 group',
            href: '#',
            [
              div(classes: 'flex items-center gap-3', [
                span(
                  classes: 'material-symbols-outlined text-[20px] text-outline group-hover:text-primary transition-colors',
                  attributes: {'data-icon': 'group'},
                  [Component.text('group')],
                ),
                span(classes: 'font-label-md text-label-md', [
                  Component.text('العملاء والمستخدمين'),
                ]),
              ]),
            ],
          ),

          div(classes: 'px-3 pb-2 pt-5 text-[11px] font-bold text-outline uppercase tracking-wider font-label-sm', [
            Component.text('التسويق والتقارير'),
          ]),

          // Item: Coupons
          a(
            classes:
                'flex items-center justify-between px-3.5 py-3 rounded-xl text-on-surface-variant hover:bg-surface-container hover:text-primary transition-all duration-150 group',
            href: '#',
            [
              div(classes: 'flex items-center gap-3', [
                span(
                  classes: 'material-symbols-outlined text-[20px] text-outline group-hover:text-primary transition-colors',
                  attributes: {'data-icon': 'confirmation_number'},
                  [Component.text('confirmation_number')],
                ),
                span(classes: 'font-label-md text-label-md', [
                  Component.text('الكوبونات والعروض'),
                ]),
              ]),
            ],
          ),

          // Item: Analytics
          a(
            classes:
                'flex items-center justify-between px-3.5 py-3 rounded-xl text-on-surface-variant hover:bg-surface-container hover:text-primary transition-all duration-150 group',
            href: '#',
            [
              div(classes: 'flex items-center gap-3', [
                span(
                  classes: 'material-symbols-outlined text-[20px] text-outline group-hover:text-primary transition-colors',
                  attributes: {'data-icon': 'trending_up'},
                  [Component.text('trending_up')],
                ),
                span(classes: 'font-label-md text-label-md', [
                  Component.text('التقارير والمبيعات'),
                ]),
              ]),
            ],
          ),

          // Item: Settings
          a(
            classes:
                'flex items-center justify-between px-3.5 py-3 rounded-xl text-on-surface-variant hover:bg-surface-container hover:text-primary transition-all duration-150 group',
            href: '#',
            [
              div(classes: 'flex items-center gap-3', [
                span(
                  classes: 'material-symbols-outlined text-[20px] text-outline group-hover:text-primary transition-colors',
                  attributes: {'data-icon': 'settings'},
                  [Component.text('settings')],
                ),
                span(classes: 'font-label-md text-label-md', [
                  Component.text('إعدادات المتجر وFirebase'),
                ]),
              ]),
            ],
          ),
        ]),

        // System Status & Cloud Sync Card
        div(classes: 'p-space-md border-t border-surface-container-high/30', [
          div(classes: 'p-3 bg-surface-container-low rounded-xl border border-surface-container flex flex-col gap-2', [
            div(classes: 'flex items-center justify-between', [
              div(classes: 'flex items-center gap-2', [
                span(classes: 'w-2.5 h-2.5 rounded-full bg-emerald-500 animate-ping', []),
                span(classes: 'font-label-md text-label-md font-bold text-on-surface', [
                  Component.text('Firebase Sync'),
                ]),
              ]),
              span(classes: 'font-label-sm text-label-sm text-emerald-600 font-bold bg-emerald-50 px-2 py-0.5 rounded-md', [
                Component.text('متصل 100%'),
              ]),
            ]),
            p(classes: 'font-body-sm text-body-sm text-outline', [
              Component.text('تمت المزامنة اللحظية مع تطبيق Flutter بنجاح.'),
            ]),
          ]),
        ]),

        // Admin Profile & Logout Section
        div(classes: 'px-space-md py-3.5 bg-surface-container-low/60 border-t border-surface-container-high/40 flex items-center justify-between', [
          div(classes: 'flex items-center gap-3', [
            div(classes: 'w-10 h-10 rounded-full bg-primary-fixed flex items-center justify-center text-primary font-bold overflow-hidden ring-2 ring-primary/20', [
              img(
                classes: 'w-full h-full object-cover',
                src:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDi5Vl4um2g7dJ0bWGj3914eVET2-jKRXvU5u-YTQAEpguJwA9KvSXym0_-Kt4Z-agGYXEIB8W4PGLpMelRuNuCttlSbPnFqsJffMbQearxBrZe_x0F9DIzw-um9WF0FL0v9CQtlDgYNR1TTcigwd-E1HhlL9k8U09HY8icJzDAdQDMuL9nYTkXqGBz5-BOMAIbJHhJl_dcKnhw6MWKRcBjeS_6w9zfyM0ucDSOeSCSm7nb2SY2AGsV',
                alt: 'Admin Portrait',
              ),
            ]),
            div(classes: 'flex flex-col', [
              span(classes: 'font-label-md text-label-md font-bold text-on-surface', [
                Component.text('م. عبد الله السعيد'),
              ]),
              span(classes: 'font-label-sm text-label-sm text-outline', [
                Component.text('مدير المتجر التنفيذي'),
              ]),
            ]),
          ]),
          button(
            classes: 'p-2 rounded-xl text-outline hover:text-error hover:bg-error-container/30 transition-colors',
            attributes: {'title': 'تسجيل الخروج'},
            [
              span(
                classes: 'material-symbols-outlined text-[20px]',
                attributes: {'data-icon': 'logout'},
                [Component.text('logout')],
              ),
            ],
          ),
        ]),
      ],
    );
  }
}
