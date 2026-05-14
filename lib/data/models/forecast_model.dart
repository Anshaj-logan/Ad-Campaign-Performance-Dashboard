class ForecastModel {

  final String date;
  final double predictedCtr;
  final double lowerBound;
  final double upperBound;

  ForecastModel({
    required this.date,
    required this.predictedCtr,
    required this.lowerBound,
    required this.upperBound,
  });

  factory ForecastModel.fromJson(
      Map<String, dynamic> json,
      ) {

    return ForecastModel(

      date: json['date'],

      predictedCtr:
      (json['predicted_ctr']).toDouble(),

      lowerBound:
      (json['lower_bound']).toDouble(),

      upperBound:
      (json['upper_bound']).toDouble(),
    );
  }
}