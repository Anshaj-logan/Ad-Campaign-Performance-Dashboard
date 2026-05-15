import 'package:ad_campaign_performance_dashboard/domain/entities/campaign_entity.dart';

abstract class CampaignRepository {
  Future<List<CampaignEntity>> getCampaigns();
}
