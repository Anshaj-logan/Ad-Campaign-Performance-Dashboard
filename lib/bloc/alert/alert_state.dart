import '../../domain/entities/anomaly_entity.dart';

abstract class AlertState {}

class AlertInitial
    extends AlertState {}

class AlertLoading
    extends AlertState {}

class AlertLoaded
    extends AlertState {

  final List<AnomalyEntity> anomalies;

  AlertLoaded(this.anomalies);
}

class AlertError
    extends AlertState {

  final String message;

  AlertError(this.message);
}