

import 'package:ad_campaign_performance_dashboard/domain/entities/anomaly_entity.dart';

class AnomalyModel extends AnomalyEntity {

  AnomalyModel({
    required super.id,
    required super.type,
    required super.severity,
    required super.campaignId,
    required super.campaignName,
    required super.metric,
    required super.actualValue,
    required super.expectedValue,
    required super.deviationPercent,
    required super.message,
    required super.detectedAt,
  });

  factory AnomalyModel.fromJson(
      Map<String, dynamic> json,
      ) {

    return AnomalyModel(

      id: json['id'] ?? '',

      type: json['type'] ?? '',

      severity: json['severity'] ?? '',

      campaignId:
      json['campaign_id'] ?? '',

      campaignName:
      json['campaign_name'] ?? '',

      metric:
      json['metric'] ?? '',

      actualValue:
      (json['actual_value'] ?? 0)
          .toDouble(),

      expectedValue:
      (json['expected_value'] ?? 0)
          .toDouble(),

      deviationPercent:
      (json['deviation_percent'] ?? 0)
          .toDouble(),

      message:
      json['message'] ?? '',

      detectedAt:
      json['detected_at'] ?? '',
    );
  }
}