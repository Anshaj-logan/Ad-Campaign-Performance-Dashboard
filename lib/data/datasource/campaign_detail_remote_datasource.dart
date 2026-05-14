import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';

import '../models/history_model.dart';

abstract class CampaignDetailRemoteDataSource {

  Future<List<HistoryModel>>
  getCampaignHistory(String id);
}

class CampaignDetailRemoteDataSourceImpl
    implements CampaignDetailRemoteDataSource {

  final Dio dio;

  CampaignDetailRemoteDataSourceImpl(
      this.dio,
      );

  @override
  Future<List<HistoryModel>>
  getCampaignHistory(String id) async {

    try {

      final response = await dio.get(
        '/campaigns/$id/history',
      );

      final data = response.data is String
          ? jsonDecode(response.data)
          : response.data;

      final List history =
      data['history'];

      return history.map((e) {

        return HistoryModel.fromJson(e);

      }).toList();

    } catch (e) {

      throw Exception(e.toString());
    }
  }
}