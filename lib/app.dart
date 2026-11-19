import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/header_bar.dart';
import 'components/sidebar.dart';
import 'pages/add_product_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/products_page.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return ProviderScope(
      child: div(
        classes:
            'w-full h-full flex overflow-hidden bg-background text-on-surface font-body-md text-body-md antialiased selection:bg-primary selection:text-on-primary',
        [
          // 1. Right Sidebar (RTL Navigation)
          const Sidebar(),

          // 2. Main Content Area (Header + Dashboard Body)
          div(classes: 'flex-1 flex flex-col h-full overflow-hidden bg-background', [
            const HeaderBar(),
            Router(routes: [
              Route(
                path: '/',
                title: 'لوحة التحكم الإدارية | متجر نبض',
                builder: (context, state) => const DashboardPage(),
              ),
              Route(
                path: '/products',
                title: 'إدارة المنتجات والمخزون | متجر نبض',
                builder: (context, state) => const ProductsPage(),
              ),
              Route(
                path: '/add-product',
                title: 'إضافة منتج جديد | متجر نبض',
                builder: (context, state) => const AddProductPage(),
              ),
            ]),
          ]),
        ],
      ),
    );
  }
}
