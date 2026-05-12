import 'package:ad_campaign_performance_dashboard/domain/entities/campaign_entity.dart';
import 'package:ad_campaign_performance_dashboard/domain/usecases/get_campaigns_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import 'campaign_event.dart';
import 'campaign_state.dart';

class CampaignBloc
    extends Bloc<CampaignEvent, CampaignState> {

  final GetCampaignsUseCase getCampaignsUseCase;

  List<CampaignEntity> allCampaigns = [];

  CampaignBloc(this.getCampaignsUseCase)
      : super(CampaignInitial()) {

    on<FetchCampaignsEvent>(_fetchCampaigns);

    on<FilterCampaignEvent>(_filterCampaigns);
  }

  /// FETCH CAMPAIGNS
  Future<void> _fetchCampaigns(
      FetchCampaignsEvent event,
      Emitter<CampaignState> emit,
      ) async {

    emit(CampaignLoading());

    try {

      final campaigns =
      await getCampaignsUseCase.call();

      allCampaigns = campaigns;

      emit(
        CampaignLoaded(campaigns),
      );

    } catch (e) {

      emit(
        CampaignError(e.toString()),
      );
    }
  }

  /// FILTER CAMPAIGNS
  void _filterCampaigns(
      FilterCampaignEvent event,
      Emitter<CampaignState> emit,
      ) {

    /// IMPORTANT FIX
    if (allCampaigns.isEmpty) return;

    /// SHOW ALL
    if (event.status == 'All') {

      emit(
        CampaignLoaded(
          List.from(allCampaigns),
        ),
      );

      return;
    }

    /// FILTERED LIST
    final filtered = allCampaigns.where(
          (campaign) {

        return campaign.status
            .toLowerCase()
            .trim() ==

            event.status
                .toLowerCase()
                .trim();
      },
    ).toList();

    emit(
      CampaignLoaded(filtered),
    );
  }
}