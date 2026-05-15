class SummaryEntity {

  final double totalSpend;

  final int totalImpressions;

  final int totalClicks;

  final double overallCtr;

  final List<ChannelEntity> byChannel;

  final List<TopCampaignEntity> topCampaigns;

  SummaryEntity({
    required this.totalSpend,
    required this.totalImpressions,
    required this.totalClicks,
    required this.overallCtr,
    required this.byChannel,
    required this.topCampaigns,
  });
}

class ChannelEntity {

  final String channel;
  final double spend;

  ChannelEntity({
    required this.channel,
    required this.spend,
  });
}

class TopCampaignEntity {

  final String id;
  final String name;
  final double ctr;
  final double spend;

  TopCampaignEntity({
    required this.id,
    required this.name,
    required this.ctr,
    required this.spend,
  });
}