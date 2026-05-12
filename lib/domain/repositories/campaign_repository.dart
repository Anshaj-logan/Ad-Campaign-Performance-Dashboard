import '../entities/campaign_entity.dart';

abstract class CampaignRepository {
  Future<List<CampaignEntity>> getCampaigns();
}