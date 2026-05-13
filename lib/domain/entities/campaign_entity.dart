import 'package:equatable/equatable.dart';

class CampaignEntity extends Equatable {
  final String id;
  final String name;
  final String status;

  final String objective;
  final String channel;

  final double spend;
  final double budget;

  final int impressions;
  final int clicks;

  final String startDate;
  final String thumbnail;

  final String currency;

  const CampaignEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.objective,
    required this.channel,
    required this.spend,
    required this.budget,
    required this.impressions,
    required this.clicks,
    required this.startDate,
    required this.thumbnail,
    required this.currency,
  });

  double get ctr {
    if (impressions == 0) return 0;

    return (clicks / impressions) * 100;
  }

  double get budgetUtilization {
    if (budget == 0) return 0;

    return (spend / budget) * 100;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    status,
    objective,
    channel,
    spend,
    budget,
    impressions,
    clicks,
    startDate,
    thumbnail,
    currency,
  ];
}
