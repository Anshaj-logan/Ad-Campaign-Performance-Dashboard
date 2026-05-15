import 'package:ad_campaign_performance_dashboard/data/datasource/summary_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import 'summary_event.dart';
import 'summary_state.dart';

class SummaryBloc
    extends Bloc<
        SummaryEvent,
        SummaryState> {

  final SummaryRemoteDataSource
  remoteDataSource;

  String selectedRange = 'last_7_days';

  SummaryBloc(this.remoteDataSource)
      : super(SummaryInitial()) {

    on<FetchSummaryEvent>(
      _fetchSummary,
    );
  }

  Future<void> _fetchSummary(

      FetchSummaryEvent event,

      Emitter<SummaryState> emit,

      ) async {

    emit(SummaryLoading());

    try {

      selectedRange = event.range;

      final result =
      await remoteDataSource
          .getSummary(
        event.range,
      );

      emit(
        SummaryLoaded(result),
      );

    } catch (e) {

      emit(
        SummaryError(
          e.toString(),
        ),
      );
    }
  }
}