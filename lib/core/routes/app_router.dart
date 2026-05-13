import 'package:ad_campaign_performance_dashboard/core/navigation/bottom_nav_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',

    routes: [
      GoRoute(
        path: '/',
        name: 'dashboard',

        builder: (context, state) => const BottomNavPage(),
      ),
    ],
  );
}
