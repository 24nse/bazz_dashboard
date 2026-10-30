import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/header_bar.dart';
import 'components/sidebar.dart';
import 'pages/dashboard_page.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return div(
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
          ]),
        ]),
      ],
    );
  }
}
