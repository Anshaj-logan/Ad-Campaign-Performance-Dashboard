class HistoryModel {

  final String date;
  final double ctr;

  HistoryModel({
    required this.date,
    required this.ctr,
  });

  factory HistoryModel.fromJson(
      Map<String, dynamic> json,
      ) {

    return HistoryModel(
      date: json['date'],
      ctr: (json['ctr']).toDouble(),
    );
  }
}