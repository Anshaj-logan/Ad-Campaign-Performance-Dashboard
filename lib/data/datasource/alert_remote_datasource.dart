import 'dart:convert';

import 'package:ad_campaign_performance_dashboard/data/models/anomaly_model.dart';
import 'package:ad_campaign_performance_dashboard/data/models/live_metric_model.dart';
import 'package:dio/dio.dart';

abstract class AlertRemoteDataSource {
  Future<List<LiveMetricModel>> getLiveMetrics();

  Future<List<AnomalyModel>> detectAnomalies(List<LiveMetricModel> metrics);
}

class AlertRemoteDataSourceImpl implements AlertRemoteDataSource {
  final Dio dio;

  AlertRemoteDataSourceImpl(this.dio);

  @override
  Future<List<LiveMetricModel>> getLiveMetrics() async {
    final response = await dio.get('/campaigns/metrics/live');

    final data = response.data is String
        ? jsonDecode(response.data)
        : response.data;

    final List campaigns = data['campaigns'];

    return campaigns.map((e) {
      return LiveMetricModel.fromJson(e);
    }).toList();
  }

  @override
  Future<List<AnomalyModel>> detectAnomalies(
    List<LiveMetricModel> metrics,
  ) async {
    try {
      final response = await dio.post(
        '/anomaly/detect',

        data: {
          "metrics": metrics.map((e) {
            return {
              "campaign_id": e.id,

              "spend": e.spendLastHour,

              "ctr": e.ctrLastHour,
            };
          }).toList(),
        },
      );

      final data = response.data is String
          ? jsonDecode(response.data)
          : response.data;

      final List anomalies = data['anomalies'];

      return anomalies.map((e) {
        return AnomalyModel.fromJson(e);
      }).toList();
    } catch (e) {
      /// FALLBACK LOCAL MOCK

      return metrics.map((e) {
        final isSpendSpike = e.spendLastHour > 100;

        return AnomalyModel(
          id: 'mock_${e.id}',

          type: isSpendSpike ? 'spend_spike' : 'ctr_drop',

          severity: isSpendSpike ? 'high' : 'medium',

          campaignId: e.id,

          campaignName: e.id,

          metric: isSpendSpike ? 'spend_last_hour' : 'ctr_last_hour',

          actualValue: isSpendSpike ? e.spendLastHour : e.ctrLastHour * 100,

          expectedValue: isSpendSpike ? 60 : 5,

          deviationPercent: isSpendSpike ? 72 : -38,

          message: isSpendSpike
              ? 'Spend is unusually high'
              : 'CTR dropped below expected',

          detectedAt: DateTime.now().toIso8601String(),
        );
      }).toList();
    }
  }
}
