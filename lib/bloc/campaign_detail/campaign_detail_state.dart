

import 'package:ad_campaign_performance_dashboard/data/models/history_model.dart';
import 'package:ad_campaign_performance_dashboard/domain/entities/forecast_entity.dart';

abstract class CampaignDetailState {}

class CampaignDetailInitial
    extends CampaignDetailState {}

class CampaignDetailLoading
    extends CampaignDetailState {}

class CampaignDetailLoaded
    extends CampaignDetailState {

  final List<HistoryModel> history;

  final List<ForecastEntity> forecast;

  CampaignDetailLoaded(
      this.history,
      this.forecast,
      );
}

class CampaignDetailError
    extends CampaignDetailState {

  final String message;

  CampaignDetailError(this.message);
}