import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'bloc/campaign/campaign_bloc.dart';
import 'core/network/dio_client.dart';
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
}