

import 'package:ad_campaign_performance_dashboard/domain/entities/summary_entity.dart';

abstract class SummaryState {}

class SummaryInitial
    extends SummaryState {}

class SummaryLoading
    extends SummaryState {}

class SummaryLoaded
    extends SummaryState {

  final SummaryEntity summary;

  SummaryLoaded(this.summary);
}

class SummaryError
    extends SummaryState {

  final String message;

  SummaryError(this.message);
}