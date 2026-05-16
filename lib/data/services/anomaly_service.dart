import '../../domain/entities/anomaly_entity.dart';

import '../models/live_metric_model.dart';

class AnomalyService {

  List<AnomalyEntity> detectAnomalies(
      List<LiveMetricModel> metrics,
      ) {

    List<AnomalyEntity> anomalies = [];

    for (final metric in metrics) {

      /// SPEND SPIKE
      if (metric.spendLastHour > 100) {

        anomalies.add(

          AnomalyEntity(

            id:
            'spike_${metric.id}',

            type:
            'spend_spike',

            severity:
            'high',

            campaignId:
            metric.id,

            campaignName:
            metric.id,

            metric:
            'spend_last_hour',

            actualValue:
            metric.spendLastHour,

            expectedValue:
            60,

            deviationPercent:
            72,

            message:
            'Spend is unusually high',

            detectedAt:
            DateTime.now()
                .toIso8601String(),
          ),
        );
      }

      /// CTR DROP
      if (metric.ctrLastHour < 0.045) {

        anomalies.add(

          AnomalyEntity(

            id:
            'ctr_${metric.id}',

            type:
            'ctr_drop',

            severity:
            'medium',

            campaignId:
            metric.id,

            campaignName:
            metric.id,

            metric:
            'ctr_last_hour',

            actualValue:
            metric.ctrLastHour * 100,

            expectedValue:
            5,

            deviationPercent:
            -38,

            message:
            'CTR dropped below expected',

            detectedAt:
            DateTime.now()
                .toIso8601String(),
          ),
        );
      }
    }

    return anomalies;
  }
}