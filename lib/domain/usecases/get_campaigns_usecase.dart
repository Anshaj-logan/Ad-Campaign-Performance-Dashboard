import 'package:ad_campaign_performance_dashboard/domain/entities/campaign_entity.dart';
import 'package:ad_campaign_performance_dashboard/domain/repositories/campaign_repository.dart';

class GetCampaignsUseCase {
  final CampaignRepository repository;

  GetCampaignsUseCase(this.repository);

  Future<List<CampaignEntity>> call() async {
    return await repository.getCampaigns();
  }
}
