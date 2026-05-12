import 'package:equatable/equatable.dart';

class CampaignEntity extends Equatable {
  final String id;
  final String name;
  final String status;
  final double spend;
  final double budget;
  final int impressions;
  final int clicks;

  const CampaignEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.spend,
    required this.budget,
    required this.impressions,
    required this.clicks,
  });

  double get ctr {
    if (impressions == 0) return 0;
    return (clicks / impressions) * 100;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    status,
    spend,
    budget,
    impressions,
    clicks,
  ];
}