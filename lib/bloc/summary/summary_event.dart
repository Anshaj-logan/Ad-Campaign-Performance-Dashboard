abstract class SummaryEvent {}

class FetchSummaryEvent
    extends SummaryEvent {

  final String range;

  FetchSummaryEvent(this.range);
}