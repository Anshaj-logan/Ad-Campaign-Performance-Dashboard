import 'package:ad_campaign_performance_dashboard/bloc/campaign_detail/campaign_detail_bloc.dart';
import 'package:ad_campaign_performance_dashboard/data/datasource/summary_remote_datasource.dart';
import 'package:ad_campaign_performance_dashboard/data/services/local_forecast_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';


import 'bloc/campaign/campaign_bloc.dart';
import 'bloc/summary/summary_bloc.dart';
import 'core/network/dio_client.dart';
import 'data/datasource/campaign_detail_remote_datasource.dart';
import 'data/datasource/campaign_remote_datasource.dart';
import 'data/repositories/campaign_repository_impl.dart';
import 'domain/repositories/campaign_repository.dart';
import 'domain/usecases/get_campaigns_usecase.dart';


final sl = GetIt.instance;

Future<void> init() async {

  // Bloc
  sl.registerFactory(
        () => CampaignBloc(sl()),
  );

  // UseCase
  sl.registerLazySingleton(
        () => GetCampaignsUseCase(sl()),
  );

  // Repository
  sl.registerLazySingleton<CampaignRepository>(
        () => CampaignRepositoryImpl(sl()),
  );

  // DataSource
  sl.registerLazySingleton<CampaignRemoteDataSource>(
        () => CampaignRemoteDataSourceImpl(sl()),
  );

  // Dio
  sl.registerLazySingleton<Dio>(
        () => DioClient().dio,
  );

  /// DETAIL BLOC
  sl.registerFactory(
        () => CampaignDetailBloc(
      sl(),
      sl(),
    ),
  );

  /// DETAIL DATASOURCE
  sl.registerLazySingleton<
      CampaignDetailRemoteDataSource>(
        () =>
        CampaignDetailRemoteDataSourceImpl(
          sl(),
        ),
  );

  sl.registerLazySingleton(
        () => LocalForecastService(),
  );

  /// SUMMARY DATASOURCE
  sl.registerLazySingleton<
      SummaryRemoteDataSource>(
        () => SummaryRemoteDataSourceImpl(
      sl(),
    ),
  );

  /// SUMMARY BLOC
  sl.registerFactory(
        () => SummaryBloc(sl()),
  );
}