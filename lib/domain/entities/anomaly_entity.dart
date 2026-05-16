class AnomalyEntity {

  final String id;

  final String type;

  final String severity;

  final String campaignId;

  final String campaignName;

  final String metric;

  final double actualValue;

  final double expectedValue;

  final double deviationPercent;

  final String message;

  final String detectedAt;

  AnomalyEntity({
    required this.id,
    required this.type,
    required this.severity,
    required this.campaignId,
    required this.campaignName,
    required this.metric,
    required this.actualValue,
    required this.expectedValue,
    required this.deviationPercent,
    required this.message,
    required this.detectedAt,
  });
}