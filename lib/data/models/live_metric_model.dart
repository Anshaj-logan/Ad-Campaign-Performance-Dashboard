class LiveMetricModel {

  final String id;
  final int impressionsLastHour;
  final int clicksLastHour;
  final double spendLastHour;
  final double ctrLastHour;

  LiveMetricModel({
    required this.id,
    required this.impressionsLastHour,
    required this.clicksLastHour,
    required this.spendLastHour,
    required this.ctrLastHour,
  });

  factory LiveMetricModel.fromJson(
      Map<String, dynamic> json,
      ) {

    return LiveMetricModel(
      id: json['id'],

      impressionsLastHour:
      json['impressions_last_hour'],

      clicksLastHour:
      json['clicks_last_hour'],

      spendLastHour:
      (json['spend_last_hour']).toDouble(),

      ctrLastHour:
      (json['ctr_last_hour']).toDouble(),
    );
  }
}