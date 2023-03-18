import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:magento_app/common/config/network/api_endpoints.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/domain/models/customer_model.dart';

class AccountRepository {
  final Dio _dio;

  AccountRepository(this._dio);

  Future<String?> login({
    required String username,
    required String password,
  }) async {
    final params = {
      'username': username,
      'password': password,
    };
    try {
      final result =
          await _dio.request('${NetworkConfig.baseUrl}${ApiEndpoints.login}',
              data: params,
              options: Options(
                method: 'POST',
              ));
      if (result.statusCode == 200) {
        return result.data;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<CustomerModel?> getCustomerInfor(String token) async {
    try {
      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.getCustomerInfor}',
          options: Options(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': 'Bearer $token'},
          ));
      if (result.statusCode == 200) {
        return CustomerModel.fromJson(result.data);
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
