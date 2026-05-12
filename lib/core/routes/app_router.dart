import 'package:ad_campaign_performance_dashboard/presentation/pages/campaign_list_page.dart';
import 'package:go_router/go_router.dart';



class AppRouter {

  static final router = GoRouter(

    initialLocation: '/',

    routes: [

      GoRoute(
        path: '/',
        name: 'campaigns',

        builder: (context, state) =>
        const CampaignListPage(),
      ),
    ],
  );
}