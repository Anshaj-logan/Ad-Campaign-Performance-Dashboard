

import 'package:ad_campaign_performance_dashboard/domain/entities/forecast_entity.dart';

class LocalForecastService {

  List<ForecastEntity> generateForecast(
      List<double> history,
      ) {

    final lastCtr = history.last;

    return List.generate(7, (index) {

      final growth =
          (index + 1) * 0.0015;

      final prediction =
          lastCtr + growth;

      return ForecastEntity(

        date:
        'Day ${index + 1}',

        predictedCtr: prediction,

        lowerBound:
        prediction - 0.003,

        upperBound:
        prediction + 0.003,
      );
    });
  }
}