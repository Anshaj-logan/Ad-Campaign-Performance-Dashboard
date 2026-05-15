

import 'package:ad_campaign_performance_dashboard/domain/entities/campaign_entity.dart';

abstract class CampaignState {}

class CampaignInitial extends CampaignState {}

class CampaignLoading extends CampaignState {}

class CampaignLoaded extends CampaignState {
  final List<CampaignEntity> campaigns;

  CampaignLoaded(this.campaigns);
}

class CampaignError extends CampaignState {
  final String message;

  CampaignError(this.message);
}