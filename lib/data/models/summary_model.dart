

import 'package:ad_campaign_performance_dashboard/domain/entities/summary_entity.dart';

class SummaryModel extends SummaryEntity {

  SummaryModel({
    required super.totalSpend,
    required super.totalImpressions,
    required super.totalClicks,
    required super.overallCtr,
    required super.byChannel,
    required super.topCampaigns,
  });

  factory SummaryModel.fromJson(
      Map<String, dynamic> json,
      ) {

    final summary = json['summary'];

    return SummaryModel(

      totalSpend:
      (summary['total_spend'])
          .toDouble(),

      totalImpressions:
      summary['total_impressions'],

      totalClicks:
      summary['total_clicks'],

      overallCtr:
      (summary['overall_ctr'])
          .toDouble(),

      byChannel:
      (summary['by_channel'] as List)
          .map(
            (e) => ChannelEntity(
          channel: e['channel'],
          spend:
          (e['spend']).toDouble(),
        ),
      ).toList(),

      topCampaigns:
      (summary['top_campaigns']
      as List)
          .map(
            (e) => TopCampaignEntity(
          id: e['id'],
          name: e['name'],
          ctr:
          (e['ctr']).toDouble(),
          spend:
          (e['spend'])
              .toDouble(),
        ),
      ).toList(),
    );
  }
}