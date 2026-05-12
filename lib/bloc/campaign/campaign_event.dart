abstract class CampaignEvent {}

class FetchCampaignsEvent extends CampaignEvent {}

class FilterCampaignEvent extends CampaignEvent {
  final String status;

  FilterCampaignEvent(this.status);
}