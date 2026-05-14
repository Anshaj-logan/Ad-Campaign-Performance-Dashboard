abstract class CampaignDetailEvent {}

class FetchCampaignHistoryEvent
    extends CampaignDetailEvent {

  final String campaignId;

  FetchCampaignHistoryEvent(
      this.campaignId,
      );
}