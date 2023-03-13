import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:magento_app/common/config/app_config.dart';
import 'package:magento_app/common/config/network/api_endpoints.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/domain/models/cms_block_response_model.dart';

class HomeRepository {
  final Dio _dio;

  HomeRepository(this._dio);

  Future<CmsBlockResponse> getHomeData( ) async {
    final result = await _dio.request(
        '${NetworkConfig.baseUrl}${ApiEndpoints.cmsHome}',
        options: Options(
          method: 'GET',
          headers: <String, dynamic>{r'Authorization': NetworkConfig.token},
        ));
    final CmsBlockResponse response =
    CmsBlockResponse.fromJson(result.data);
    debugPrint('-----------${jsonDecode(response.content ??'')}');
    return response;
  }


}