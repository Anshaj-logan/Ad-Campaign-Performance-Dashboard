import 'package:ad_campaign_performance_dashboard/data/datasource/campaign_detail_remote_datasource.dart';
import 'package:ad_campaign_performance_dashboard/data/services/local_forecast_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import 'campaign_detail_event.dart';
import 'campaign_detail_state.dart';

class CampaignDetailBloc
    extends Bloc<
        CampaignDetailEvent,
        CampaignDetailState> {

  final CampaignDetailRemoteDataSource
  remoteDataSource;

  final LocalForecastService
  forecastService;

  CampaignDetailBloc(
      this.remoteDataSource,
      this.forecastService,
      ) : super(CampaignDetailInitial()) {

    on<FetchCampaignHistoryEvent>(
      _fetchHistory,
    );
  }

  Future<void> _fetchHistory(

      FetchCampaignHistoryEvent event,

      Emitter<CampaignDetailState> emit,

      ) async {

    emit(CampaignDetailLoading());

    try {

      final history =
      await remoteDataSource
          .getCampaignHistory(
        event.campaignId,
      );

      final ctrValues = history
          .map((e) => e.ctr)
          .toList();

      final forecast =
      forecastService
          .generateForecast(
        ctrValues,
      );

      emit(
        CampaignDetailLoaded(
          history,
          forecast,
        ),
      );

    } catch (e) {

      emit(
        CampaignDetailError(
          e.toString(),
        ),
      );
    }
  }
}