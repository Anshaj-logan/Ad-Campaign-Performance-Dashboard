

import 'package:ad_campaign_performance_dashboard/domain/entities/campaign_entity.dart';

class CampaignModel extends CampaignEntity {
  const CampaignModel({
    required super.id,
    required super.name,
    required super.status,
    required super.spend,
    required super.budget,
    required super.impressions,
    required super.clicks,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      spend: (json['spend'] ?? 0).toDouble(),
      budget: (json['budget'] ?? 0).toDouble(),
      impressions: json['impressions'] ?? 0,
      clicks: json['clicks'] ?? 0,
    );
  }
}