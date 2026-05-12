import 'package:ad_campaign_performance_dashboard/data/datasource/campaign_remote_datasource.dart';
import 'package:ad_campaign_performance_dashboard/domain/entities/campaign_entity.dart';
import 'package:ad_campaign_performance_dashboard/domain/repositories/campaign_repository.dart';

class CampaignRepositoryImpl implements CampaignRepository {
  final CampaignRemoteDataSource remoteDataSource;

  CampaignRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CampaignEntity>> getCampaigns() async {
    return await remoteDataSource.getCampaigns();
  }
}
