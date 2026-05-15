import 'dart:convert';

import 'package:ad_campaign_performance_dashboard/data/models/summary_model.dart';
import 'package:dio/dio.dart';



abstract class SummaryRemoteDataSource {

  Future<SummaryModel>
  getSummary(String range);
}

class SummaryRemoteDataSourceImpl
    implements SummaryRemoteDataSource {

  final Dio dio;

  SummaryRemoteDataSourceImpl(
      this.dio,
      );

  @override
  Future<SummaryModel>
  getSummary(String range) async {

    final response = await dio.get(
      '/campaigns/summary',
      queryParameters: {
        'range': range,
      },
    );

    final data =
    response.data is String
        ? jsonDecode(response.data)
        : response.data;

    return SummaryModel.fromJson(
      data,
    );
  }
}