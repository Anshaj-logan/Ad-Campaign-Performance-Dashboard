import 'package:ad_campaign_performance_dashboard/domain/entities/campaign_entity.dart';
import 'package:ad_campaign_performance_dashboard/presentation/pages/campaign_detail_page.dart';
import 'package:go_router/go_router.dart';



import '../navigation/bottom_nav_page.dart';

class AppRouter {

  static final router = GoRouter(

    initialLocation: '/',

    routes: [

      GoRoute(
        path: '/',
        builder: (context, state) =>
        const BottomNavPage(),
      ),

      GoRoute(
        path: '/campaign-detail',

        name: 'campaign-detail',

        builder: (context, state) {

          final campaign =
          state.extra as CampaignEntity;

          return CampaignDetailPage(
            campaign: campaign,
          );
        },
      ),
    ],
  );
}