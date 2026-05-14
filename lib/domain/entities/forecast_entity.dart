class ForecastEntity {

  final String date;

  final double predictedCtr;

  final double lowerBound;

  final double upperBound;

  ForecastEntity({
    required this.date,
    required this.predictedCtr,
    required this.lowerBound,
    required this.upperBound,
  });
}