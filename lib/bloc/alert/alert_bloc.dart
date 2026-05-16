import 'dart:async';

import 'package:ad_campaign_performance_dashboard/data/datasource/alert_remote_datasource.dart';
import 'package:ad_campaign_performance_dashboard/data/services/notification_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'alert_event.dart';
import 'alert_state.dart';

class AlertBloc extends Bloc<AlertEvent, AlertState> {
  final AlertRemoteDataSource remoteDataSource;

  final NotificationService notificationService;

  Timer? timer;

  /// PREVENT DUPLICATE NOTIFICATIONS
  final Set<String> shownAlerts = {};

  AlertBloc(this.remoteDataSource, this.notificationService)
    : super(AlertInitial()) {
    on<FetchAlertsEvent>(_fetchAlerts);

    /// INITIAL FETCH
    add(FetchAlertsEvent());

    timer = Timer.periodic(const Duration(seconds: 30), (_) {
      add(FetchAlertsEvent());
    });
  }

  Future<void> _fetchAlerts(
    FetchAlertsEvent event,

    Emitter<AlertState> emit,
  ) async {
    if (state is! AlertLoaded) {
      emit(AlertLoading());
    }

    try {
      /// LIVE METRICS
      final metrics = await remoteDataSource.getLiveMetrics();

      /// DETECT ANOMALIES
      final anomalies = await remoteDataSource.detectAnomalies(metrics);

      /// PUSH NOTIFICATION
      for (final anomaly in anomalies) {
        final uniqueKey = '${anomaly.type}_${anomaly.campaignId}';

        /// AVOID DUPLICATE ALERTS
        if (!shownAlerts.contains(uniqueKey)) {
          shownAlerts.add(uniqueKey);

          await notificationService.showNotification(
            title: anomaly.type,

            body: '${anomaly.campaignId} anomaly detected',
          );
        }
      }

      emit(AlertLoaded(anomalies));
    } catch (e) {
      emit(AlertError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    timer?.cancel();

    return super.close();
  }
}
