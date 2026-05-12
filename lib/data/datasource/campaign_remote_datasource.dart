import 'dart:convert';

import 'package:ad_campaign_performance_dashboard/core/constants/api_constants.dart';
import 'package:ad_campaign_performance_dashboard/data/models/campaign_model.dart';
import 'package:dio/dio.dart';





abstract class CampaignRemoteDataSource {
  Future<List<CampaignModel>> getCampaigns();
}

class CampaignRemoteDataSourceImpl
    implements CampaignRemoteDataSource {

  final Dio dio;

  CampaignRemoteDataSourceImpl(this.dio);

  @override
  Future<List<CampaignModel>> getCampaigns() async {

    try {

      final response = await dio.get(
        ApiConstants.campaigns,
      );


      final data = response.data is String
          ? jsonDecode(response.data)
          : response.data;

      final List campaigns =
      data['campaigns'];

      return campaigns.map((e) {

        return CampaignModel.fromJson(e);

      }).toList();

    } catch (e, stackTrace) {

      print(e.toString());

      print(stackTrace.toString());

      throw Exception(e.toString());
    }
  }
}